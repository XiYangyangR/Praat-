# 打开TextGrid文件
fileName$ = "D:\任金洋\05、2023-2024学年第二学期\暑期洛本卓白语调查\调查报告\数据\textgrid\yhn.TextGrid"  
# 输入TextGrid文件路径

textGrid = Read from file: fileName$
writeInfoLine: 1
n=Get number of intervals: 1
ans=0
for i from 1 to n
    label$ = Get label of interval: 1, i
    
    if label$ != ""
        startTime = Get start point: 1, i
        endTime = Get end point: 1, i
        appendInfoLine: label$,tab$,'startTime:2',tab$, 'endTime:2'
	ans=ans+1
    endif
endfor

appendInfoLine: "共",ans
