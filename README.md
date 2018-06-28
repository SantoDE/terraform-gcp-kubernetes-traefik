gcloud init
gcloud auth application-default login

export GOOGLE_PROJECT=$(gcloud config get-value project)