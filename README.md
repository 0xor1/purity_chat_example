#Purity Chat Example

An simple example application to demo the Purity framework.
Run [`test/integration/index_without_purity.html`](http://0xor1.github.io/purity_chat_example/without_purity/)
to see four instances of the app running on the client with the views directly
consuming the sources, or run [`test/integration/index_with_purity.html`](http://0xor1.github.io/purity_chat_example/)
to see the whole app running on the client with remote proxy objects
relaying messages through the **Host** also running on the client.

Run `pub build` and then run `build/bin/host.dart` to run the app as a full distributed
app, browse to `http://localhost:4346/` to see the view consuming the remote proxy object 
with all messages being realyed to/from the **Host** via websockets.

The chat example application demonstrates how to set up a realtime single page web app
with google oauth2 login that links multiple user sessions to create a sinlge global
chat room. But more importantly how the whole application stack can be run on a single
page allowing developers to debug multiple clients and the server side all in a single
web page, which is a very powerful experience, even more so when considering that it can be
configured to run with and without the purity framework to make debugging you application code 
accross multiple clients and the server, in isolation from the purity framework, even simpler.