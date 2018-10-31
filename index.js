const process = require('child_process');
const path = require('path');
const fs = require('fs');
const chalk = require('chalk');

const BASE_DIRNAME = __dirname;
const isManageLog = false;

const readLog = (filePath) => {
  console.log(fs.readFileSync(`${filePath}`, {
    encoding: 'utf8'
  }));
  // console.log(chalk.bgRed(fs.readFileSync(`${filePath}`, 'utf8')));
}
const writeFile = (filePath, data, callback) => {
  fs.writeFile(filePath, data, (error) => {
    if (error) throw err;
    console.log(chalk.yellow(`【error】: lua is error， log is ${filePath}`));
    if (callback) {
      callback(filePath);
    }
  });
}
const printLog = (fileName, log) => {
  const date = new Date();
  const logDate = date.toLocaleDateString().replace(/\//g, "-");
  const logPath = path.join(BASE_DIRNAME, `/log/`);
  const logFile = path.join(BASE_DIRNAME, `/log/${fileName}-${logDate}.log`);
  fs.exists(logPath, (exists) => {
    if(!exists) {
      fs.mkdir(logPath, () => {
        writeFile(logFile, log, readLog);
      });
    } else {
      writeFile(logFile, log, readLog);
    }
  })
};

const options = {
  stdio: isManageLog ? [0, 1, process.stderr] : 'inherit',
  env: process.env
};

const lua = process.spawn('lua', [`./code/index.lua`], options);

// 是否接管日志
if (isManageLog) {
  lua.stderr.on('data', (data) => {
    printLog('lua错误日志', data);
  });
}

lua.on('exit', (code) => {
  if (code !== 0) {
    console.log(chalk.magenta('exit lua!'));
  }
});