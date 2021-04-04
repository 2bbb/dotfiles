// ~/.npm-init.js

const exec = require('child_process').execSync;
const path = require('path');
const fs = require('fs');

const cwd = process.cwd();
const name = cwd.split('/').pop();

const json = {
    name,
    version: '0.0.1',
    publishConfig: {
        "access": "public"
    },
    description: '',
    author: 'ISHII 2bit',
    license: 'MIT',
    keywords: [],
};

const tsconfig = {
    compilerOptions: {
        target: "es2017",
        module: "commonjs",
        moduleResolution: "node",
        strict: true,
        declaration: true,
        pretty: true,
        removeComments: false,
        sourceMap: true,
        outDir: "./lib",
        esModuleInterop: true,
        lib: ["dom", "es2017", "es2018", "es2019"]
    },
    include: [
      "./src/**/*.ts"
    ],
};

const npmignore
= `src/
lib/test/
node_modules/
`;

function writeFileIfNotExists(filepath, data) {
    if(!fs.existsSync(filepath)) fs.writeFileSync(filepath, data);
}

if(process.argv.indexOf('--ts') != -1) {
    const newest_ts = exec('npm info typescript version').toString().trim();
    const node_ver = exec('node --version').toString().trim().replace(/^v/, '').replace(/\.[^\.]+\.[^\.]+$/, '.0.0');
    Object.assign(json, {
        main: 'lib/index.js',
        files: [ 'lib' ],
        scripts: {
            start: 'node lib/index.js',
            build: 'tsc'
        },
        devDependencies: {
            "@types/node": `^${node_ver}`,
            "typescript": `^${newest_ts}`
        }
    });
    const src_dir = path.join(cwd, 'src');
    if(!fs.existsSync(src_dir)) fs.mkdirSync(src_dir);
    writeFileIfNotExists(path.join(src_dir, 'index.ts'), "");
    writeFileIfNotExists(path.join(cwd, 'tsconfig.json'), JSON.stringify(tsconfig, null, '  '));
    writeFileIfNotExists(path.join(cwd, '.npmignore'), npmignore);
} else {
    Object.assign(json, {
        main: 'index.js',
        scripts: {
            start: 'node index.js'
        },
    });
    if(!fs.existsSync(path.join(cwd, 'index.js'))) fs.writeFileSync(path.join(cwd, 'index.js'), "");
}

exec(`cd ${cwd}; git init`);

module.exports = json;