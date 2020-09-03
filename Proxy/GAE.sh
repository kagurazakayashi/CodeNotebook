vim ~/XX-Net/code/default/gae_proxy/server/gae/app.yaml
# runtime: python27
# env: standard
# threadsafe: true

# handlers:
# - url: /_gh/.*
#   script: gae.application
#   secure: optional

# - url: /2
#   script: wsgi.gae_application
#   secure: optional

# - url: /favicon.ico
#   script: gae.application
#   secure: optional

# - url: /.*
#   script: legacy.application
#   secure: optional

# libraries:
# - name: pycrypto
#   version: "latest"


~/google-cloud-sdk/gcloud init
~/google-cloud-sdk/gcloud app deploy ~/XX-Net/code/default/gae_proxy/server/gae/app.yaml