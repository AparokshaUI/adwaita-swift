docs:
	@sourcedocs generate --min-acl private -r --spm-module Adwaita

swiftlint:
	@swiftlint --autocorrect
