# -*- coding:utf-8 -*-
from encodings import utf_8
from telegram import Update
# pip uninstall python-telegram-bot telegram
# pip install python-telegram-bot --upgrade
# https://github.com/python-telegram-bot/python-telegram-bot/wiki
from telegram.ext import CallbackContext
from telegram.ext import Updater
from telegram.ext import CommandHandler
from telegram.ext import MessageHandler, Filters
import datetime

c_TGTOKEN = '*:*-*'


print('正在初始化...')


def start(update: Update, context: CallbackContext):
    """響應 /start"""
    fromUser: str = update.message.from_user.username
    text: str = '你好， '+fromUser+' ！'
    print(text)
    context.bot.send_message(chat_id=update.effective_chat.id, text=text)

start_handler = CommandHandler('start', start)
dispatcher.add_handler(start_handler)


def echo(update: Update, context: CallbackContext):
    """收到的所有非命令文字訊息(聊天)"""
    print(update)

echoHandler = MessageHandler(Filters.text & (
    ~Filters.command), echo, pass_job_queue=True)
dispatcher.add_handler(echoHandler)


def new_member(update, context):
    """新成員加入"""
    for member in update.message.new_chat_members:
        if member.is_bot:
            continue
        member.username
        text: str = '你好， '+fromUser+' ！'
        print(text)
        context.bot.send_message(chat_id=update.effective_chat.id, text=text)

newMemberHandler = MessageHandler(
    Filters.status_update.new_chat_members, new_member)
updater.dispatcher.add_handler(newMemberHandler)


def timing(context: CallbackContext):
    """每幾秒觸發一次"""
    print(datetime.datetime.now())
    # context.bot.send_message(chat_id='@YOUR CHANELL ID',text='job executed')

jobQueue.run_repeating(timing, interval=5.0, first=0.0)


updater.start_polling()
updater.idle()
print('初始化完成。')