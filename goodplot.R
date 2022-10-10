library(tidyverse)

four.minutes <- read_csv("hmk/good_data?.csv")

good.plot <- ggplot(four.minutes)+
  geom_point(aes(x = Test.Condition, y = TE))+
  geom_point(aes(x = Test.Condition, y = TE_IsoAMP), color = "blue")+
  geom_point(aes(x = Test.Condition, y = `0.5M.EDTA`), color = "red")+
  geom_point(aes(x = Test.Condition, y = `0.3M.EDTA`), color = "yellow")+
  geom_point(aes(x = Test.Condition, y = `160mM.EDTA`), color = "green")+
  scale_y_continuous(name = "Absorbance at 655 nm")

print(good.plot)

better.plot <- ggplot(four.minutes, aes(x = Test.Condition)) +
  geom_point(aes(y = TE, color = "TE")) +
  geom_point(aes(y = TE_IsoAMP, color = "TE_IsoAMP")) +
  geom_point(aes(y = `0.5M.EDTA`, color = "0.5M.EDTA"))+
  geom_point(aes(y = `0.3M.EDTA`, color = "0.3M.EDTA"))+
  geom_point(aes(y = `160mM.EDTA`, color = "160mM.EDTA"))+
  scale_y_continuous(name = "Absorbance at 655 nm")+
  scale_x_discrete(name = "Test Condition")
print(better.plot)

ggsave("goodplot.png", plot = better.plot, width = 5, height = 7, dpi = 300)
