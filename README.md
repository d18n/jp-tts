# jp-tts
Japanese Text-to-Speech using espnet

Currently working on some tooling for language learning, and wanted the ability to generate relatively realistic audio files for example sentences

This is a flask app that allows you to send a request to /synthesize?q=YOUR_TEXT_HERE and will return a .wav file with the synthesized audio

Currently this runs on the CPU, am planning on adding support for the GPU

This runs using pre-trained models from espnet, and I would like to add support for more voices and train my own

To get this up and running locally, you can pull the image from dockerhub:

`docker pull d18n/jp-tts`

`docker run -it -p 1337:1337 d18n/jp-tts`

Or, you can build the image locally

`docker build . -t jp-tts`

`docker run -it -p 1337:1337 jp-tts`

You can test that it's working by making a request to:

`http://localhost:1337?q=何してるの？`

P.S. This is the first time I've pushed anything to Dockerhub, and really the first project I've done with docker in general 
so if you have any suggestions, feel free to make an issue!
