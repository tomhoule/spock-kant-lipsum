FROM haskell:8.0.2

WORKDIR /kantlipsum

COPY . /kantlipsum

RUN stack build
CMD stack exec kantlipsum-exe
