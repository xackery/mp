const Jimp = require('jimp');
const path = require('path');

let files = [];
for (let i = 2; i < process.argv.length; i++) {
  files.push(path.resolve(process.argv[i]));
}

for (let file of files) {
  Jimp.read(file, (err, image) => {
    if (err) throw err;
    image
      .resize(64, (image.getHeight() / image.getWidth()) * 64)
      .write(file);
  });
}