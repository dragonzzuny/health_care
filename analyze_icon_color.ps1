
Add-Type -AssemblyName System.Drawing

$imagePath = "c:\Users\SK_Park\Documents\02_SignCare\assets\icon\to_be_converted_icon.png"

try {
    $bitmap = [System.Drawing.Bitmap]::FromFile($imagePath)
} catch {
    Write-Error "Could not load image: $_"
    exit 1
}

$colorCounts = @{}

# Sample pixels
for ($x = 0; $x -lt $bitmap.Width; $x += 1) { # Check every pixel for accuracy on small feature
    for ($y = 0; $y -lt $bitmap.Height; $y += 1) {
        $pixel = $bitmap.GetPixel($x, $y)
        if ($pixel.A -lt 250) { continue }
        
        # Simple clustering
        $r = $pixel.R
        $g = $pixel.G
        $b = $pixel.B
        
        # Filter for GREEN: Green must be dominant
        # Relaxed check: G > R and G > B. 
        # To be "magnifying glass green" it's likely distinct.
        if ($g -gt $r -and $g -gt $b) {
             # Round to nearest 10 to cluster similar shades
            $r_c = [Math]::Round($r / 10) * 10
            $g_c = [Math]::Round($g / 10) * 10
            $b_c = [Math]::Round($b / 10) * 10
            
            $key = "$r_c,$g_c,$b_c"
            if ($colorCounts.ContainsKey($key)) {
                $colorCounts[$key]++
            } else {
                $colorCounts[$key] = 1
            }
        }
    }
}

# Find most common GREEN color
$mostCommon = $colorCounts.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 1

if ($null -ne $mostCommon) {
    $rgb = $mostCommon.Key -split ","
    $r = [int]$rgb[0]
    $g = [int]$rgb[1]
    $b = [int]$rgb[2]
    
    # Convert to Hex
    $hex = "#{0:X2}{1:X2}{2:X2}" -f $r, $g, $b
    Write-Output "Dominant Green Color: $hex"
} else {
    Write-Output "No dominant green color found."
}

$bitmap.Dispose()
