# Settings taken from https://devcenter.heroku.com/articles/paperclip-s3#international-users-additional-configuration
# To override the default URL structure and place the bucket’s name “domain-style” in the URL (e.g. yourbucketname.s3.amazonaws.com)
Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
# If you are seeing the following error: “The bucket you are attempting to access must be addressed using the specified endpoint. Please send all future requests to this endpoint.” Try setting the specified endpoint with the s3_host_name config var.
Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'