
-- 构建函数
require("./code/demo10/createHtml")

BEGIN()

N = 0
entry = entry0
fwrite('<ul>\n')
dofile('./code/demo10/htmlConfig.lua')
fwrite('<ul>\n')

N = 0
entry = entry1
dofile('./code/demo10/htmlConfig.lua')

END()