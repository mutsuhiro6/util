
let startDateSec = system('date -j -f "%Y/%m/%d" "2019/04/01" "+%s"') "日付を更新
let endDateSec = system('date -j -f "%Y/%m/%d" "2019/06/12" "+%s"') "日付を更新
let outputCSV = "cal.csv" "出力先を更新
let meetingOKDoWList = ['火', '水', '木', '金'] "ミーティング可能な曜日のリストを更新

let currentDateSec = startDateSec
let oneDateSec = 60 * 60 * 24
execute ":redir! > " . outputCSV
while currentDateSec <= endDateSec
  if (index(meetingOKDoWList, strftime("%a", currentDateSec)) >= 0)
    silent! echon strftime("%Y/%m/%d,%a,NG,,NG,,", currentDateSec) . "\n"
  endif
  let currentDateSec += oneDateSec
endwhile
redir END
