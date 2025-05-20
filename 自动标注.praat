##基于基频自动标注
##说明：根据基频有无自动标注并输出textgrid文件
##元音最短持续时间栏保证填入时间比最短的元音短即可，当然也不要太短以免无法排除零零散散的游离段（如可以填大致时间的一半）
##“每段元音首尾各截去的比例”栏填希望去掉多少比例的元音起始段与结束段不参与F1F2提取，默认为0
##（若有Formant与Pitch文件为正常成分，请放心饮用（）
#======================%% Code %%========================#
form
	comment 元音最短持续时间(s)   
	positive: "floorduration","0.05"
	comment 每段元音首尾各截去的比例(0~1)
	real: "donotanalysis","0"
endform

sp=selected("Sound")
name$=selected$("Sound");

selectObject: sp
To Pitch: 0,75,600                    ;可根据发音人实际情况调整预测的基频下限75Hz和上限600Hz（不过基本与F1F2的提取无关）
To TextGrid... "1",""

dur=Get total duration
sum=0
t=0
step=0.01


while t<dur
	selectObject:"Pitch "+name$
	f0=Get value at time: t,"hertz","linear"
	if f0>50
		start=t
		ans=0
		while f0>0 && t<dur
			ans=ans+1
			t=t+step
			f0=Get value at time: t,"hertz","linear"
		endwhile

		end=t-step

		if (end-start)>floorduration
			trimdur=(end-start)*donotanalysis
            start=start+trimdur
            end=end-trimdur

            selectObject: "TextGrid "+name$
            Insert boundary: 1, start
            Insert boundary: 1, end
		endif
	else
		t=t+step
	endif
endwhile
selectObject: "Pitch "+name$
Remove

#======================%% Code %%========================#
#written by 任金洋
#version 2024.12.15