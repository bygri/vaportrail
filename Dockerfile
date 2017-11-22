FROM swift:4

WORKDIR /app
COPY . .

RUN swift package --enable-prefetching resolve
RUN swift package clean
CMD swift test
