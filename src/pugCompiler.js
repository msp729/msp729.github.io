const pug = require('pug');
const fs = require('fs');
const process = require("process");
let pugFilePath = process.argv[2];
let outFilePath = process.argv[3];

if (!pugFilePath.endsWith(".pug")) {
  pugFilePath += ".pug";
}
if (outFilePath === undefined) {
  outFilePath = pugFilePath.slice(0, pugFilePath.length-4) + ".html";
}

console.log("Compiling pug file at " + pugFilePath);
console.log("Writing to output file at " + outFilePath);

const pugSource = fs.readFileSync(pugFilePath).toString();
if (pugSource.startsWith("//module")) {process.exit(0);}

const compiledPug = pug.render(pugSource, {basedir: "."});
fs.writeFile(outFilePath, compiledPug, err => {
  if (err) {
    console.error(err); // error handling.
  }
});
