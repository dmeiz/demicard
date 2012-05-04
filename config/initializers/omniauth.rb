Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, 'H9DBb7g2lixRmpuuZX0BIw', 'GzOoWSSCiQfgkqetgasWF3duhIy30cwQRCoLv1VyE'
  provider :facebook, '348089315256011', 'b3ea49336152b6a6a6c1ef41d61554ac'
end
