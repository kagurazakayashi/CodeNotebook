package main

import (
	"fmt"
	"log"
	"net/http"
	"net/url"
	"os"
	"os/signal"

	tgbotapi "github.com/go-telegram-bot-api/telegram-bot-api/v5"
	"golang.org/x/net/proxy"
)

func main() {

	fmt.Println("START")
	socks5 := "socks5://localhost:23332"
	client := &http.Client{}
	tgProxyURL, err := url.Parse(socks5)
	if err != nil {
		log.Printf("代理服务器地址配置错误: %s\n", err)
	}
	tgDialer, err := proxy.FromURL(tgProxyURL, proxy.Direct)
	if err != nil {
		log.Printf("代理服务器错误: %s\n", err)
	}
	tgTransport := &http.Transport{
		Dial: tgDialer.Dial,
	}
	client.Transport = tgTransport

	bot, err := tgbotapi.NewBotAPIWithClient("6075096035:AAHdHZ0-SRu2DtaJwOV-3WAlXHn5j0Gp6ew", "https://api.telegram.org/bot%s/%s", client)
	if err != nil {
		log.Printf("连接电报服务器出现问题: %s\n", err)
		return
	}

	bot.Debug = true

	log.Printf("已登录 %s", bot.Self.UserName)

	go getUpdates(bot)

	signalch := make(chan os.Signal, 1)
	signal.Notify(signalch, os.Interrupt, os.Kill)
	signal := <-signalch
	fmt.Println("收到系统信号: ", signal)
	if signal == os.Interrupt || signal == os.Kill {
		bot.StopReceivingUpdates()
		client.CloseIdleConnections()
		fmt.Println("终止 BOT")
		os.Exit(0)
	}

}

func getUpdates(bot *tgbotapi.BotAPI) {
	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60
	updates := bot.GetUpdatesChan(u)
	for update := range updates {
		log.Print(".")
		if update.Message == nil { // 过滤非消息类型
			continue
		}

		log.Printf("收到来自会话 %s(%d) 里 %s(%d) 的消息：%s", update.Message.Chat.UserName, update.Message.Chat.ID, update.Message.From.UserName, update.Message.From.ID, update.Message.Text)

		// msg := tgbotapi.NewEditMessageCaption(update.Message.Chat.ID, update.Message.MessageID, "asasdsad")
		msg := tgbotapi.NewMessage(update.Message.Chat.ID, update.Message.Text)
		msg.ReplyToMessageID = update.Message.MessageID

		if _, err := bot.Send(msg); err != nil {
			log.Printf("发送消息失败: %s", err)
		}
		log.Printf("已向 %s(%d) 发送消息: %s", update.Message.Chat.UserName, update.Message.Chat.ID, msg.Text)
	}
}
