# On-Device Gemma3 Setup

This project now bundles the logic required to run the Gemma3 1B (Q4_K_M) model fully offline through a locally spawned `llama.cpp` server. Follow the steps below to prepare your development machine or physical device.

## 1. Download Resources

Use the enhanced downloader script to fetch both the quantized model and the platform-specific `llama-server` binary. This stores everything under `~/.signcare_models/`.

```bash
dart run scripts/model_downloader_cli.dart gemma
```

The script automatically:
- Downloads `gemma-3-1b-it-Q4_K_M.gguf` (~0.7 GB) from Hugging Face.
- Verifies the file size and records the version.
- Retrieves the appropriate `llama-server` binary for macOS, Linux, Windows, or Android (hosted from the official llama.cpp release feed).
- Marks binaries as executable (Unix platforms).

> **Tip**: If you are targeting Android, run the script on the device (via `dart` in a Termux shell) or push the downloaded files to the device’s app storage path (`/data/data/<package>/files/signcare_models`).

## 2. Launch the App in Offline Mode

1. Run the Flutter application as usual (`flutter run -d <device>`).
2. Navigate to the chat screen and open the **AI 설정** sheet.
3. Switch to **오프라인 모드** — the router now detects the Gemma3 model and launches the bundled `llama-server` automatically.
4. The UI badge under the app bar should show “Gemma3 사용 가능” once the local inference pipeline is ready.

## 3. Troubleshooting

- **Model not detected**: Delete `~/.signcare_models/` and re-run the downloader to ensure the latest version and correct hash.
- **Server start failure**: Confirm the binary is executable (`chmod +x ~/.signcare_models/bin/llama-server`) and that no firewall is blocking `localhost:8080`.
- **Low-memory devices**: Gemma3 1B Q4 requires ~2.5 GB RAM during inference. Close other apps to prevent Android/iOS from killing the process.

## 4. Updating Resources

Re-run the downloader command whenever you need to refresh to a newer quantization or binary build. The router keeps using the most recent files found in the models directory.

