home <- "~/Desktop"
setwd(home)
library(data.table)
library(ggplot2)
step_2 <- fread("step_2.csv",header=TRUE,sep=",",data.table =F)

#出力
plot(step_2) #時間とN(入力数)の関係性のグラフ
plot(step_2,type="l") #時間とN(入力数)の関係性のグラフ(線でつないだもの）
library(GGally)
ggpairs(data.frame(step_2))
df <- data.frame(step_2)
ggplot(df,aes(x=mat.size,y=time.sec.))+geom_point()+geom_smooth()#geom_smooth:回帰線の追加

pdf("matsize_time.pdf",width = 8,height = 8)
dev.off()


#今回作成したprogramの時間計算量はO(N^3)である
#入力数が10倍になった時と比較するプログラムを作る 入力数10倍になった時に出力の時間は何倍になったのか
junk_list <- vector(length=17)
for(i in 1:17){
  idx <- step_2[match(step_2[i,1]*10,step_2[,1]),]
  junk <- idx[,2]/step_2[i,2]
  junk_list[i] <- junk
}
mean(junk_list)#978.2582
hist(junk_list)#ばらつきはあるので中央値で解釈しても良いかも
median(junk_list)#969.6863
#N数が10倍になった時、出力にかかる時間は978倍(約1000倍（10^3))となった。
#つまり計算量は入力数が増えた時、実行時間が増えるだいたいの割合を示す関係を表す



#time=f(mat size)
#fを見つける問題＝回帰問題＝線形モデルではないけど、線形モデルに帰る/exponetial 関数(指数関数 e^x)

#x <- seq(1,100,by=0.1) #aからbまでcづつ増加するベクトルを生成
#y <- exp(x) #e^x
x <- df$mat.size
y <- df$time.sec.
#plot(x,y,type = "l")
result_gaussian <- glm(y~x, family = gaussian(link ="log"))
#result_gamma <- glm(y~x, family = Gamma)

#glmにより算出された式を手持ちのデータの上に上書きする
pdf("glm_model.pdf",width = 8,height = 8)
plot(x,y)
xp <- seq(min(x),max(x),length=100)
lines(xp, exp(2.962797 + 0.004252*xp))
dev.off()
