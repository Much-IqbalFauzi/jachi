//
//  ConvTalk.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 15/06/25.
//

import Foundation
import SwiftUI

class ConvTalk {
    var id: UUID
    var hanzi: String
    var pinyin: String
    var translate: String
    var highlight: String
    var isUser: Bool
    var isError: Bool
    var hanziView: any View
    var pinYinView: any View

    init(
        hanzi: String, pinyin: String, translate: String, highlight: String = "", isUser: Bool = false, isError: Bool = false,
        hanziView: any View = Text(""), pinYinView: any View = Text("")
    ) {
        self.id = UUID()
        self.hanzi = hanzi
        self.pinyin = pinyin
        self.translate = translate
        self.highlight = highlight
        self.isUser = isUser
        self.isError = isError
        self.hanziView = hanziView
        self.pinYinView = pinYinView
    }
}

extension ConvTalk {

    static let emptyTalk = ConvTalk(
        hanzi: "...", pinyin: "...", translate: "...", highlight: "")
    
    // TODO: OUR List Pronounce

    static let talkUser1 = ConvTalk(
        hanzi: "你好，我要买一公斤零食",
        pinyin: "Nǐ hǎo, wǒ yào mǎi yì gōng jīn líng shí",
        translate: "Hello, I want to buy one kilogram of snacks.",
        highlight: "一公斤零食",
        isUser: true,
        hanziView: Text("你好，我要买\(Text("一公斤零食").bold())").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("Nǐ hǎo, wǒ yào mǎi \(Text("yì gōng jīn líng shí").bold())")
    )
    
    static let talkAuntie1 = ConvTalk(
        hanzi: "一公斤三十块",
        pinyin: "Yì gōng jīn sānshí kuài",
        translate: "One kilogram is thirty yuan.",
        highlight: "",
        hanziView: Text("一公斤三十块"),
        pinYinView: Text("Yì gōng jīn sānshí kuài")
    )
    
    static let talkUser2 = ConvTalk(
        hanzi: "一公斤三十块？可以打折吗？",
        pinyin: "Yì gōng jīn sānshí kuài? Kěyǐ dǎzhé ma?",
        translate: "Thirty yuan per kilogram? Can I get a discount?",
        highlight: "可以打折",
        isUser: true,
        hanziView: Text("一公斤三十块？\(Text("可以打折").bold())吗？").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("Yì gōng jīn sānshí kuài? \(Text("Kěyǐ dǎzhé").bold()) ma?")
    )
    
    static let talkAuntie2 = ConvTalk(
        hanzi: "要买几份？",
        pinyin: "Yào mǎi jǐ fèn?",
        translate: "How many portions do you want to buy?",
        highlight: "",
        hanziView: Text("要买几份？"),
        pinYinView: Text("Yào mǎi jǐ fèn?")
    )
    
    static let talkUser3 = ConvTalk(
        hanzi: "三公斤七十块可以吗？",
        pinyin: "Sān gōng jīn qīshí kuài kěyǐ ma?",
        translate: "Is seventy yuan for three kilograms okay?",
        highlight: "三公斤七十",
        isUser: true,
        hanziView: Text("\(Text("三公斤七十").bold())块可以吗？").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("\(Text("Sān gōng jīn qīshí").bold()) kuài kěyǐ ma?")
    )
    
    static let talkAuntie3 = ConvTalk(
        hanzi: "三分七十块，我们的烤鸭是精选的",
        pinyin: "Sān fèn qīshí kuài, wǒmen de dōng xi shì jīngxuǎn de",
        translate: "Three portions for seventy yuan — our products is carefully selected.",
        highlight: "",
        hanziView: Text("三分七十块，我们的烤鸭是精选的"),
        pinYinView: Text("Sān fèn qīshí kuài, wǒmen de dōng xi shì jīngxuǎn de")
    )
    
    static let talkUser4 = ConvTalk(
        hanzi: "好的阿姨，现金支付可以吗？",
        pinyin: "Hǎo de āyí, xiànjīn zhīfù kěyǐ ma?",
        translate: "Alright, auntie, is it okay if I pay with cash?",
        highlight: "现金支付",
        isUser: true,
        hanziView: Text("好的阿姨，\(Text("现金支付").bold())可以吗？").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("Hǎo de āyí, \(Text("xiànjīn zhīfù").bold()) kěyǐ ma?")
    )
    
    static let talkAuntie4 = ConvTalk(
        hanzi: "可以",
        pinyin: "Kěyǐ",
        translate: "Yes.",
        highlight: "",
        hanziView: Text("可以"),
        pinYinView: Text("Kěyǐ")
    )
    
    static let talkUser5 = ConvTalk(
        hanzi: "好的，这给您阿姨，谢谢",
        pinyin: "Hǎo de, zhè gěi nín āyí, xièxie",
        translate: "Alright, here you go, auntie. Thank you.",
        highlight: "",
        isUser: true,
        hanziView: Text("好的，这给您阿姨，谢谢").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("Hǎo de, zhè gěi nín āyí, xièxie")
    )
    
    static let talkAuntie5 = ConvTalk(
        hanzi: "",
        pinyin: "",
        translate: "",
        highlight: "",
        hanziView: Text(""),
        pinYinView: Text("")
    )
    
    
    // talkUser6 || talkAuntie6 -- talkAuntie10 || talkUser 10 topic1, convo2
    static let talkUser6 = ConvTalk(
        hanzi: "你好，我要买一份牛肉丸",
        pinyin: "Nǐ hǎo, wǒ yào mǎi yí fèn niú ròu wán",
        translate: "Hello, I'd like to buy a portion of beef meatballs.",
        highlight: "一份牛肉丸",
        isUser: true,
        hanziView: Text("你好，我要买\(Text("一份牛肉丸").bold())").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("Nǐ hǎo, wǒ yào mǎi \(Text("yí fèn niú ròu wán").bold())")
    )
    
    static let talkAuntie6 = ConvTalk(
        hanzi: "一份四十四块",
        pinyin: "Yí fèn sìshísì kuài",
        translate: "One portion is forty-four yuan.",
        highlight: "",
        hanziView: Text("一份四十四块"),
        pinYinView: Text("Yí fèn sìshísì kuài")
    )
    
    static let talkUser7 = ConvTalk(
        hanzi: "一公斤三十块？有促销吗？",
        pinyin: "Yì gōng jīn sānshí kuài? Yǒu cùxiāo ma?",
        translate: "Thirty yuan per kilogram? Is there a promotion?",
        highlight: "有促销",
        isUser: true,
        hanziView: Text("一公斤三十块？\(Text("有促销").bold())吗？").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("Yì gōng jīn sānshí kuài? \(Text("Yǒu cùxiāo").bold()) ma?")
    )
    
    static let talkAuntie7 = ConvTalk(
        hanzi: "要买几份？",
        pinyin: "Yào mǎi jǐ fèn?",
        translate: "How many portions do you want to buy?",
        highlight: "",
        hanziView: Text("要买几份？"),
        pinYinView: Text("Yào mǎi jǐ fèn?")
    )
    
    static let talkUser8 = ConvTalk(
        hanzi: "两份八十块可以吗？",
        pinyin: "Liǎng fèn bāshí kuài kěyǐ ma?",
        translate: "Is eighty yuan for two portions okay?",
        highlight: "两份八十",
        isUser: true,
        hanziView: Text("\(Text("两份八十").bold())块可以吗？").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("\(Text("Liǎng fèn bāshí").bold()) kuài kěyǐ ma?")
    )
    
    static let talkAuntie8 = ConvTalk(
        hanzi: "三分七十块，我们的东西是精选的",
        pinyin: "Sān fèn qīshí kuài, wǒmen de dōng xi shì jīngxuǎn de",
        translate: "Three portions for seventy yuan — our products are carefully selected.",
        highlight: "",
        hanziView: Text("三分七十块，我们的东西是精选的"),
        pinYinView: Text("Sān fèn qīshí kuài, wǒmen de dōng xi shì jīngxuǎn de")
    )
    
    static let talkUser9 = ConvTalk(
        hanzi: "好的阿姨，用微信支付可以吗？",
        pinyin: "Hǎo de āyí, yòng Wēixìn zhīfù kěyǐ ma?",
        translate: "Alright, auntie, can I pay with WeChat Pay?",
        highlight: "用微信支付",
        isUser: true,
        hanziView: Text("好的阿姨，\(Text("用微信支付").bold())可以吗？").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("Hǎo de āyí, \(Text("yòng Wēixìn zhīfù").bold()) kěyǐ ma?")
    )
    
    static let talkAuntie9 = ConvTalk(
        hanzi: "可以", pinyin: "Kěyǐ",
        translate: "Yes",
        highlight: "",
        hanziView: Text("可以"),
        pinYinView: Text("Kěyǐ")
    )
    
    static let talkUser10 = ConvTalk(
        hanzi: "好的，这给您阿姨，谢谢",
        pinyin: "Hǎo de, zhè gěi nín āyí, xièxie",
        translate: "Alright, here you go, auntie. Thank you.",
        highlight: "",
        isUser: true,
        hanziView: Text("好的，这给您阿姨，谢谢").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("Hǎo de, zhè gěi nín āyí, xièxie")
    )
    
    static let talkAuntie10 = ConvTalk(
        hanzi: "",
        pinyin: "",
        translate: "",
        highlight: "",
        hanziView: Text(""),
        pinYinView: Text("")
    )
    
    // talkUser11 || talkAuntie11 -- talkAuntie14 || talkUser 14 convo2, topic1
    static let talkAuntie11 = ConvTalk(
        hanzi: "你好！想买什么？",
        pinyin: "Nǐ hǎo! Xiǎng mǎi shénme?",
        translate: "Hello! What would you like to buy?",
        highlight: "你好",
        hanziView: Text("\(Text("你好").bold())！想买什么？"),
        pinYinView: Text("\(Text("Nǐ hǎo").bold())! Xiǎng mǎi shénme?")
    )
    
    static let talkUser11 = ConvTalk(
        hanzi: "我要买小笼包，多少钱？",
        pinyin: "Wǒ yào mǎi xiǎo lóng bāo, duōshǎo qián?",
        translate: "I'd like to buy xiaolongbao, how much is it?",
        highlight: "小笼包",
        isUser: true,
        hanziView: Text("我要买\(Text("小笼包").bold())，多少钱？").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("Wǒ yào mǎi \(Text("xiǎo lóng bāo").bold()), duōshǎo qián?")
    )
    
    static let talkAuntie12 = ConvTalk(
        hanzi: "十四块",
        pinyin: "Shísì kuài",
        translate: "Fourteen yuan.",
        highlight: "",
        hanziView: Text("十四块"),
        pinYinView: Text("Shísì kuài")
    )
    
    static let talkUser12 = ConvTalk(
        hanzi: "谢谢。 如果两份这个多少钱？我要买几份",
        pinyin: "xiè xie. Rúguǒ liǎng fèn duōshǎo qián? wǒ yào mǎi jǐ fèn",
        translate: "Thank you. If I buy two portions, how much would that be? I want to buy a few portions.",
        highlight: "谢谢",
        isUser: true,
        hanziView: Text("\(Text("谢谢").bold())。 如果两份这个多少钱？我要买几份").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("\(Text("xiè xie").bold()). Rúguǒ liǎng fèn duōshǎo qián? wǒ yào mǎi jǐ fèn")
    )
    
    static let talkAuntie13 = ConvTalk(
        hanzi: "十四块一份，两份二十七块",
        pinyin: "Shísì kuài yí fèn, liǎng fèn èrshíqī kuài",
        translate: "Fourteen yuan for one portion, twenty-seven yuan for two portions.",
        highlight: "",
        hanziView: Text("十四块一份，两份二十七块"),
        pinYinView: Text("Shísì kuài yí fèn, liǎng fèn èrshíqī kuài")
    )
    
    static let talkUser13 = ConvTalk(
        hanzi: "好的，我要一份，谢谢 阿姨",
        pinyin: "Hǎo de, wǒ yào yí fèn, xièxie āyí",
        translate: "Alright, I'll take one portion. Thank you, auntie.",
        highlight: "阿姨",
        isUser: true,
        hanziView: Text("好的，我要一份，谢谢 \(Text("阿姨").bold())").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("Hǎo de, wǒ yào yí fèn, xièxie \(Text("āyí").bold())")
    )
    
    static let talkAuntie14 = ConvTalk(
        hanzi: "这给你，没事！",
        pinyin: "Zhè gěi nǐ, méi shì!",
        translate: "Here you go. No problem!",
        highlight: "",
        hanziView: Text("这给你，没事！"),
        pinYinView: Text("Zhè gěi nǐ, méi shì!")
    )
    
    static let talkUser14 = ConvTalk(
        hanzi: "",
        pinyin: "",
        translate: "",
        highlight: "",
        isUser: true,
        hanziView: Text(""),
        pinYinView: Text("")
    )
    
    // talkUser6 || talkAuntie6 -- talkAuntie10 || talkUser 10 convo2, topic2
    static let talkAuntie15 = ConvTalk(
        hanzi: "你好！想买什么？",
        pinyin: "Nǐ hǎo! Xiǎng mǎi shénme?",
        translate: "Hello! What would you like to buy?",
        highlight: "",
        hanziView: Text("你好！想买什么？"),
        pinYinView: Text("Nǐ hǎo! Xiǎng mǎi shénme?")
    )
    
    static let talkUser15 = ConvTalk(
        hanzi: "我要买面条，多少钱？",
        pinyin: "Wǒ yào mǎi miàn tiáo, duōshǎo qián?",
        translate: "I'd like to buy noodles, how much is it?",
        highlight: "面条",
        isUser: true,
        hanziView: Text("我要买\(Text("面条").bold())，多少钱？").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("Wǒ yào mǎi \(Text("miàn tiáo").bold()), duōshǎo qián?")
    )
    
    static let talkAuntie16 = ConvTalk(
        hanzi: "十四块",
        pinyin: "Shísì kuài",
        translate: "Fourteen yuan.",
        highlight: "",
        hanziView: Text("十四块"),
        pinYinView: Text("Shísì kuài")
    )
    
    static let talkUser16 = ConvTalk(
        hanzi: "感谢. 如果两份这个多少钱？我要买几份",
        pinyin: "Gǎn xiè. Rúguǒ liǎng fèn duōshǎo qián? wǒ yào mǎi jǐ fèn",
        translate: "Thanks. If I buy two portions, how much would it be? I want to buy a few portions.",
        highlight: "感谢",
        isUser: true,
        hanziView: Text("\(Text("感谢").bold()). 如果两份这个多少钱？我要买几份").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("\(Text("Gǎn xiè").bold()). Rúguǒ liǎng fèn duōshǎo qián? wǒ yào mǎi jǐ fèn")
    )
    
    static let talkAuntie17 = ConvTalk(
        hanzi: "十四块一份，两份二十七块",
        pinyin: "Shísì kuài yí fèn, liǎng fèn èrshíqī kuài",
        translate: "Fourteen yuan for one portion, twenty-seven yuan for two portions.",
        highlight: "",
        hanziView: Text("十四块一份，两份二十七块"),
        pinYinView: Text("Shísì kuài yí fèn, liǎng fèn èrshíqī kuài")
    )
    
    static let talkUser17 = ConvTalk(
        hanzi: "好的，我要一份，谢谢 叔叔",
        pinyin: "Hǎo de, wǒ yào yí fèn, xièxie shūshu",
        translate: "Alright, I'll take one portion. Thank you, uncle.",
        highlight: "叔叔",
        isUser: true,
        hanziView: Text("好的，我要一份，谢谢 \(Text("叔叔").bold())").foregroundColor(Color.blizzardBlue),
        pinYinView: Text("Hǎo de, wǒ yào yí fèn, xièxie \(Text("shūshu").bold())")
    )
    
    static let talkAuntie18 = ConvTalk(
        hanzi: "这给你，没事！",
        pinyin: "Zhè gěi nǐ, méi shì!",
        translate: "Here you go. No problem!",
        highlight: "",
        hanziView: Text("这给你，没事！"),
        pinYinView: Text("Zhè gěi nǐ, méi shì!")
    )
    
    static let talkUser18 = ConvTalk(
        hanzi: "",
        pinyin: "",
        translate: "",
        highlight: "",
        isUser: true,
        hanziView: Text(""),
        pinYinView: Text("")
    )
}
