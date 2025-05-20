##无标注批量提取F1、F2（精度可能有所下降）
##说明：不需要TextGrid标注即可批量提取F1、F2（精度可能有所下降）
##元音最短持续时间栏保证填入时间比最短的元音短即可，当然也不要太短以免无法排除零零散散的游离段（如可以填大致时间的一半）
##“每段元音首尾各截去的比例”栏填希望去掉多少比例的元音起始段与结束段不参与F1F2提取，默认为0
##（若有Formant与Pitch文件为正常成分，请放心饮用（）
#======================%% Code %%========================#
form
	comment 元音最短持续时间(s)   
	#防止在提取时将很短的游离段当成目标段
	positive: "floorduration","0.1"
	comment 每段元音首尾各截去的比例(0~1)
	real: "donotanalysis","0"
endform

name$="vowel"    ;根据praat 列表栏显示的文件名更改引号内的名称（如列表栏显示“1 Sound vowel”，则输入"vowel"）
writeInfoLine:"F2"+tab$+"F1"
sp=selected("Sound")
selectObject: sp
dur=Get total duration
To Formant (burg): 0,6,5500,0.025,50  ;可根据发音人实际情况调整最大共振峰数6与阈值5500Hz
selectObject: sp
To Pitch: 0,75,600                    ;可根据发音人实际情况调整预测的基频下限75Hz和上限600Hz（不过基本与F1F2的提取无关）
sum=0
t=0
step=0.01
while t<dur
	selectObject:"Pitch "+name$
	f0=Get value at time: t,"hertz","linear"
	if f0>0
		start=t
		ans=0
		while f0>0
			ans=ans+1
			t=t+step
			f0=Get value at time: t,"hertz","linear"
		endwhile
		end=t-step
		ans=round(ans*donotanalysis)
		if (end-start)>floorduration
			selectObject:"Formant "+name$
			f1=Get mean: 1,start,end,"hertz"
			f2=Get mean: 2,start,end,"hertz"
			appendInfoLine:'f2:2',tab$,'f1:2',tab$,'ans'
			sum=sum+1
		endif
	else
		t=t+step
	endif
endwhile
appendInfoLine:"共提取",sum,"组F1F2"  ;校验
#======================%% Code %%========================#
#written by 任金洋
#version 2024.12.15