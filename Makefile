package:
	docker build -t gpt_sovits_normal --platform linux/amd64 --build-arg port=9880 --build-arg sovits_weights=./SoVITS_weights/mix_n_e100_s26200.pth --build-arg gpt_weights=./SoVITS_weights/mix_n-e15.ckpt .
	docker build -t gpt_sovits_whisper --platform linux/amd64 --build-arg port=9881 --build-arg sovits_weights=./SoVITS_weights/mix_w_e150_s9450.pth --build-arg gpt_weights=./SoVITS_weights/mix_w-e200.ckpt  .
