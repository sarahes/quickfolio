Rails.application.config.middleware.use OmniAuth::Builder do
	#set up the API keys and secrets for providers using the following format:
	#provider :provider_name, 'CONSUMER_KEY', 'CONSUMER_SECRET'

	provider :twitter, 'sEmBEzLnOm6wQiZLcwZLgw', 'Kb5zxz3ZrSPEaGkNoHz3d5iOCdMDcQlVX3phj3Sg'
	provider :linked_in, 'cgefsv4lm30b', 'NZBboW6UpL172kLM'
	provider :github, 'f4c9211b7ec2dcf4fc11', '828c8e732203351d16cf71908df5460cc63f4ab1', scope: "user,repo,gist"
end