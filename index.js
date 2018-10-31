const process = require('child_process');
const path = require('path');
const fs = require('fs');
const chalk = require('chalk');

const BASE_DIRNAME = __dirname;
const printLog = (fileName, str) => {
  const logPath = path.join(BASE_DIRNAME, `${fileName}-${new Date}.log`);
  fs.exists(logPath, (exists) => {
    if(exists) {
      callback();
    } else {
      fs.mkdir(savePath, callback);
    }
  })
  fs.writeFile(logPath, str);
  console.log(chalk.yellow(`【error】: lua is error， log is ${logPath}...`));
};

const options = {
  stdio: 'inherit'
};

const lua = process.spawn('lua', [`${BASE_DIRNAME}/code/index.lua`], options);

lua.on('exit', (code) => {
  if (code === 0) {
    console.log(chalk.magenta('【success】: lua is start!'));
  } else {
    printLog('lua错误日志', JSON.stringify(code));
  }
});
