Paperclip::Attachment.default_options.merge! \
  storage: :s3,
  s3_region: ENV['S3_REGION'],
  s3_host_name: ENV['S3_HOST_NAME'],
  s3_protocol: :https,
  s3_credentials: {
    access_key_id: ENV['S3_ACCESS_KEY_ID'],
    secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
    bucket: ENV['S3_BUCKET']
  }
