set COM_PORT=COM5

espsecure.py encrypt_flash_data --keyfile zbins/secure_signing_key.bin --address 0x020000 -o zbins/esp_secure_encrypted.bin build/esp_secure_basic.bin
esptool.py --chip esp32 --port %COM_PORT% --baud 921600 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 40m --flash_size detect 0x020000 zbins/esp_secure_encrypted.bin
