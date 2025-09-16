import os
from pathlib import Path
from urllib.parse import quote_plus
import requests


def load_service_key(env_path: Path = None) -> str:
    """Return the URL-encoded service key from a .env file."""
    env_path = env_path or Path(__file__).resolve().parents[1] / ".env"
    try:
        with open(env_path) as f:
            for line in f:
                if line.startswith("SERVICE_KEY="):
                    raw_key = line.split("=", 1)[1].strip()
                    return quote_plus(raw_key)
    except FileNotFoundError:
        pass
    raise RuntimeError(".env 파일에서 SERVICE_KEY를 찾을 수 없습니다.")


SERVICE_KEY = load_service_key()
URL = "https://apis.data.go.kr/1480523/MetalMeasuringResultService/MetalService"


def get_metal_measurement(date: str, stationcode: int, itemcode: int, timecode: str):
    params = {
        "serviceKey": SERVICE_KEY,
        "resultType": "json",
        "date": date,
        "stationcode": stationcode,
        "itemcode": itemcode,
        "timecode": timecode,
        "numOfRows": 1,
        "pageNo": 1,
    }

    try:
        response = requests.get(URL, params=params, timeout=5)
        response.raise_for_status()
    except requests.exceptions.Timeout:
        raise RuntimeError("요청 시간이 초과되었습니다. 네트워크 상태를 확인하세요.")
    except requests.exceptions.HTTPError as e:
        raise RuntimeError(f"HTTP 오류 발생: {e.response.status_code}")
    except requests.exceptions.RequestException:
        raise RuntimeError("네트워크 요청 중 알 수 없는 오류가 발생했습니다.")

    data = response.json()
    header = data.get("response", {}).get("header", {})
    if header.get("resultCode") != "00":
        raise RuntimeError(f"API 오류: {header.get('resultCode')} - {header.get('resultMsg')}")

    item = data["response"]["body"]["items"]["item"][0]
    return {
        "측정시각": item["sdate"],
        "측정소": item["stationcode"],
        "항목코드": item["itemcode"],
        "농도(ng/m³)": item["value"],
    }


if __name__ == "__main__":
    try:
        result = get_metal_measurement("20231120", 1, 90303, "RH02")
        print(result)
    except RuntimeError as err:
        print("오류:", err)
