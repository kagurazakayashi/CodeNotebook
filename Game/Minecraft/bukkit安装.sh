# 先安装 JAVA

curl -O "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" -o BuildTools.jar

java -jar BuildTools.jar

java -Xms16G -Xmx32G -jar "spigot-1.19.4.jar"
