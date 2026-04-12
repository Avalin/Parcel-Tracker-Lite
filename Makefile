# Default run command
ana:
	flutter analyze

# Default run command
run:
	flutter run

get:
	flutter pub get

upgrade:
	flutter upgrade
	flutter pub upgrade

# Open iPhone Simulator
ios-launch:
	open -a Simulator

# Open Android Emulator
android-mp36:
	flutter emulators --launch Medium_Phone_API_36.0

# Open Android Emulator
android-p6p:
	flutter emulators --launch Pixel_6_Pro

android-p3a:
	flutter emulators --launch Pixel_3a_API_34_extension_level_7_x86_64