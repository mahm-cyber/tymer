PACKAGES := $(wildcard packages/*)
FEATURES := $(wildcard packages/features/*)
BUILD-RUNNER := packages/tymer_api packages/key_value_storage

print:
	for feature in $(FEATURES); do \
		echo $${feature} ; \
	done
	for package in $(PACKAGES); do \
		echo $${package} ; \
	done

pods-clean:
	rm -Rf ios/Pods ; \
	rm -Rf ios/.symlinks ; \
	rm -Rf ios/Flutter/Flutter.framework ; \
	rm -Rf ios/Flutter/Flutter.podspec ; \
	rm ios/Podfile ; \
	rm ios/Podfile.lock ; \

get:
	flutter pub get
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Updating dependencies on $${feature}" ; \
		flutter pub get ; \
		cd ../../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Updating dependencies on $${package}" ; \
		flutter pub get ; \
		cd ../../ ; \
	done

lints:
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "adding flutter lints to $${feature}" ; \
		flutter pub add flutter_lints --dev ; \
		cd ../../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "flutter pub add flutter_lints to $${package}" ; \
		flutter pub add flutter_lints --dev ; \
		cd ../../ ; \
	done

upgrade:
	flutter pub upgrade
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Updating dependencies on $${feature}" ; \
		flutter pub upgrade ; \
		cd ../../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Updating dependencies on $${package}" ; \
		flutter pub upgrade ; \
		cd ../../ ; \
	done

lint:
	flutter analyze

format:
	flutter format --set-exit-if-changed .

testing:
	flutter test
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Running test on $${feature}" ; \
		flutter test ; \
		cd ../../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Running test on $${package}" ; \
		flutter test ; \
		cd ../../ ; \
	done

test-coverage:
	flutter test --coverage
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Running test on $${feature}" ; \
		flutter test --coverage ; \
		cd ../../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Running test on $${package}" ; \
		flutter test --coverage ; \
		cd ../../ ; \
	done

clean:
	flutter clean
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Running clean on $${feature}" ; \
		flutter clean ; \
		cd ../../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Running clean on $${package}" ; \
		flutter clean ; \
		cd ../../ ; \
	done

build-runner:
	for package in $(BUILD-RUNNER); do \
		cd $${package} ; \
		echo "Running build-runner on $${package}" ; \
		dart run build_runner build --delete-conflicting-outputs ; \
		cd ../../ ; \
	done

gen-l10n:
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Running gen-l10n on $${feature}" ; \
		flutter gen-l10n ; \
		cd ../../../ ; \
	done

cache-clean:
	dart pub cache clean
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Running clean on $${feature}" ; \
		dart pub cache clean ; \
		cd ../../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Running clean on $${package}" ; \
		dart pub cache clean ; \
		cd ../../ ; \
	done

delete-pubspeclock:
	rm -f pubspec.lock
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Deleting pubspeclock on $${feature}" ; \
		rm -f pubspec.lock ; \
		cd ../../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Deleting pubspeclock on $${package}" ; \
		rm -f pubspec.lock ; \
		cd ../../ ; \
	done

deps:
	flutter pub deps
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "flutter pub deps on $${feature}" ; \
		flutter pub deps ; \
		cd ../../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "flutter pub deps on $${package}" ; \
		flutter pub deps ; \
		cd ../../ ; \
	done

replace-strings:
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "finding l10n strings in $${feature}" ; \
		python replace_strings.py ; \
		cd ../../../ ; \
	done
