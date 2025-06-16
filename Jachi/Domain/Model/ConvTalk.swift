//
//  ConvTalk.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 15/06/25.
//

import Foundation
import SwiftUI

struct TextItem {
    var previx: String
    var suffix: String
    var highlight: String
}

class ConvTalk {
    var id: UUID
    var hanzi: String
    var pinyin: String
    var translate: String
    var highlight: String
    var isUser: Bool
    var isError: Bool
    var hanziItem: TextItem
    var pinYinItem: TextItem

    init(
        hanzi: String, pinyin: String, translate: String, highlight: String = "", isUser: Bool = false, isError: Bool = false,
        hanziItem: TextItem = TextItem(previx: "", suffix: "", highlight: ""), pinYinItem: TextItem = TextItem(previx: "", suffix: "", highlight: "")
    ) {
        self.id = UUID()
        self.hanzi = hanzi
        self.pinyin = pinyin
        self.translate = translate
        self.highlight = highlight
        self.isUser = isUser
        self.isError = isError
        self.hanziItem = hanziItem
        self.pinYinItem = pinYinItem
        
    }
    
    func buildHanzi(_ color: Color = .dustBlizzard) -> some View {
        buildTextComponent(item: hanziItem, color: color)
    }
    
    func buildPinyin(_ color: Color = .dustBlizzard) -> some View {
        buildTextComponent(item: pinYinItem, color: color)
    }
    
    struct buildTextComponent: View {
        var item: TextItem
        var color: Color
        
        var body: some View {
            Text("\(item.previx)\(Text(item.highlight).fontWeight(.bold).underline())\(item.suffix)").font(.system(size: 20)).foregroundStyle(color).fixedSize(horizontal: false, vertical: true)
        }
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
        hanziItem: TextItem(previx: "你好，我要买", suffix: "", highlight: "一公斤零食"),
        pinYinItem: TextItem(previx: "Nǐ hǎo, wǒ yào mǎi ", suffix: "", highlight: "yì gōng jīn líng shí")
    )
    
    static let talkAuntie1 = ConvTalk(
        hanzi: "一公斤三十块",
        pinyin: "Yì gōng jīn sānshí kuài",
        translate: "One kilogram is thirty yuan.",
        highlight: "",
        hanziItem: TextItem(previx: "一公斤三十块", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Yì gōng jīn sānshí kuài", suffix: "", highlight: "")
    )
    
    static let talkUser2 = ConvTalk(
        hanzi: "一公斤三十块？可以打折吗？",
        pinyin: "Yì gōng jīn sānshí kuài? Kěyǐ dǎzhé ma?",
        translate: "Thirty yuan per kilogram? Can I get a discount?",
        highlight: "可以打折",
        isUser: true,
        hanziItem: TextItem(previx: "一公斤三十块？", suffix: "吗？", highlight: "可以打折"),
        pinYinItem: TextItem(previx: "Yì gōng jīn sānshí kuài? ", suffix: " ma?", highlight: "Kěyǐ dǎzhé")
    )
    
    static let talkAuntie2 = ConvTalk(
        hanzi: "要买几份？",
        pinyin: "Yào mǎi jǐ fèn?",
        translate: "How many portions do you want to buy?",
        highlight: "",
        hanziItem: TextItem(previx: "要买几份？", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Yào mǎi jǐ fèn?", suffix: "", highlight: "")
    )
    
    static let talkUser3 = ConvTalk(
        hanzi: "三公斤七十块可以吗？",
        pinyin: "Sān gōng jīn qīshí kuài kěyǐ ma?",
        translate: "Is seventy yuan for three kilograms okay?",
        highlight: "三公斤七十",
        isUser: true,
        hanziItem: TextItem(previx: "", suffix: "块可以吗？", highlight: "三公斤七十"),
        pinYinItem: TextItem(previx: "", suffix: " kuài kěyǐ ma?", highlight: "Sān gōng jīn qīshí")
    )
    
    static let talkAuntie3 = ConvTalk(
        hanzi: "三分七十块，我们的烤鸭是精选的",
        pinyin: "Sān fèn qīshí kuài, wǒmen de dōng xi shì jīngxuǎn de",
        translate: "Three portions for seventy yuan — our products is carefully selected.",
        highlight: "",
        hanziItem: TextItem(previx: "三分七十块，我们的烤鸭是精选的", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Sān fèn qīshí kuài, wǒmen de dōng xi shì jīngxuǎn de", suffix: "", highlight: "")
    )
    
    static let talkUser4 = ConvTalk(
        hanzi: "好的阿姨，现金支付可以吗？",
        pinyin: "Hǎo de āyí, xiànjīn zhīfù kěyǐ ma?",
        translate: "Alright, auntie, is it okay if I pay with cash?",
        highlight: "现金支付",
        isUser: true,
        hanziItem: TextItem(previx: "好的阿姨，", suffix: "可以吗？", highlight: "现金支付"),
        pinYinItem: TextItem(previx: "Hǎo de āyí, ", suffix: " kěyǐ ma?", highlight: "xiànjīn zhīfù")
    )
    
    static let talkAuntie4 = ConvTalk(
        hanzi: "可以",
        pinyin: "Kěyǐ",
        translate: "Yes.",
        highlight: "",
        hanziItem: TextItem(previx: "可以", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Kěyǐ", suffix: "", highlight: "")
    )
    
    static let talkUser5 = ConvTalk(
        hanzi: "好的，这给您阿姨，谢谢",
        pinyin: "Hǎo de, zhè gěi nín āyí, xièxie",
        translate: "Alright, here you go, auntie. Thank you.",
        highlight: "",
        isUser: true,
        hanziItem: TextItem(previx: "好的，这给您阿姨，谢谢", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Hǎo de, zhè gěi nín āyí, xièxie", suffix: "", highlight: "")
    )
    
    static let talkAuntie5 = ConvTalk(
        hanzi: "",
        pinyin: "",
        translate: "",
        highlight: "",
        hanziItem: TextItem(previx: "", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "", suffix: "", highlight: "")
    )
    
    
    // talkUser6 || talkAuntie6 -- talkAuntie10 || talkUser 10 topic1, convo2
    static let talkUser6 = ConvTalk(
        hanzi: "你好，我要买一份牛肉丸",
        pinyin: "Nǐ hǎo, wǒ yào mǎi yí fèn niú ròu wán",
        translate: "Hello, I'd like to buy a portion of beef meatballs.",
        highlight: "一份牛肉丸",
        isUser: true,
        hanziItem: TextItem(previx: "你好，我要买", suffix: "", highlight: "一份牛肉丸"),
        pinYinItem: TextItem(previx: "Nǐ hǎo, wǒ yào mǎi ", suffix: "", highlight: "yí fèn niú ròu wán")
    )
    
    static let talkAuntie6 = ConvTalk(
        hanzi: "一份四十四块",
        pinyin: "Yí fèn sìshísì kuài",
        translate: "One portion is forty-four yuan.",
        highlight: "",
        hanziItem: TextItem(previx: "一份四十四块", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Yí fèn sìshísì kuài", suffix: "", highlight: "")
    )
    
    static let talkUser7 = ConvTalk(
        hanzi: "一公斤三十块？有促销吗？",
        pinyin: "Yì gōng jīn sānshí kuài? Yǒu cùxiāo ma?",
        translate: "Thirty yuan per kilogram? Is there a promotion?",
        highlight: "有促销",
        isUser: true,
        hanziItem: TextItem(previx: "一公斤三十块？", suffix: "吗？", highlight: "有促销"),
        pinYinItem: TextItem(previx: "Yì gōng jīn sānshí kuài? ", suffix: " ma?", highlight: "Yǒu cùxiāo")
    )
    
    static let talkAuntie7 = ConvTalk(
        hanzi: "要买几份？",
        pinyin: "Yào mǎi jǐ fèn?",
        translate: "How many portions do you want to buy?",
        highlight: "",
        hanziItem: TextItem(previx: "要买几份？", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Yào mǎi jǐ fèn?", suffix: "", highlight: "")
    )
    
    static let talkUser8 = ConvTalk(
        hanzi: "两份八十块可以吗？",
        pinyin: "Liǎng fèn bāshí kuài kěyǐ ma?",
        translate: "Is eighty yuan for two portions okay?",
        highlight: "两份八十",
        isUser: true,
        hanziItem: TextItem(previx: "", suffix: "块可以吗？", highlight: "两份八十"),
        pinYinItem: TextItem(previx: "", suffix: " kuài kěyǐ ma?", highlight: "Liǎng fèn bāshí")
    )
    
    static let talkAuntie8 = ConvTalk(
        hanzi: "三分七十块，我们的东西是精选的",
        pinyin: "Sān fèn qīshí kuài, wǒmen de dōng xi shì jīngxuǎn de",
        translate: "Three portions for seventy yuan — our products are carefully selected.",
        highlight: "",
        hanziItem: TextItem(previx: "三分七十块，我们的东西是精选的", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Sān fèn qīshí kuài, wǒmen de dōng xi shì jīngxuǎn de", suffix: "", highlight: "")
    )
    
    static let talkUser9 = ConvTalk(
        hanzi: "好的阿姨，用微信支付可以吗？",
        pinyin: "Hǎo de āyí, yòng Wēixìn zhīfù kěyǐ ma?",
        translate: "Alright, auntie, can I pay with WeChat Pay?",
        highlight: "用微信支付",
        isUser: true,
        hanziItem: TextItem(previx: "好的阿姨，", suffix: "可以吗？", highlight: "用微信支付"),
        pinYinItem: TextItem(previx: "Hǎo de āyí, ", suffix: " kěyǐ ma?", highlight: "yòng Wēixìn zhīfù")
    )
    
    static let talkAuntie9 = ConvTalk(
        hanzi: "可以", pinyin: "Kěyǐ",
        translate: "Yes",
        highlight: "",
        hanziItem: TextItem(previx: "可以", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Kěyǐ", suffix: "", highlight: "")
    )
    
    static let talkUser10 = ConvTalk(
        hanzi: "好的，这给您阿姨，谢谢",
        pinyin: "Hǎo de, zhè gěi nín āyí, xièxie",
        translate: "Alright, here you go, auntie. Thank you.",
        highlight: "",
        isUser: true,
        hanziItem: TextItem(previx: "好的，这给您阿姨，谢谢", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Hǎo de, zhè gěi nín āyí, xièxie", suffix: "", highlight: "")
    )
    
    static let talkAuntie10 = ConvTalk(
        hanzi: "",
        pinyin: "",
        translate: "",
        highlight: "",
        hanziItem: TextItem(previx: "", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "", suffix: "", highlight: "")
    )
    
    // talkUser11 || talkAuntie11 -- talkAuntie14 || talkUser 14 convo2, topic1
    static let talkAuntie11 = ConvTalk(
        hanzi: "你好！想买什么？",
        pinyin: "Nǐ hǎo! Xiǎng mǎi shénme?",
        translate: "Hello! What would you like to buy?",
        highlight: "你好",
        hanziItem: TextItem(previx: "", suffix: "！想买什么？", highlight: "你好"),
        pinYinItem: TextItem(previx: "", suffix: "! Xiǎng mǎi shénme?", highlight: "Nǐ hǎo")
    )
    
    static let talkUser11 = ConvTalk(
        hanzi: "我要买小笼包，多少钱？",
        pinyin: "Wǒ yào mǎi xiǎo lóng bāo, duōshǎo qián?",
        translate: "I'd like to buy xiaolongbao, how much is it?",
        highlight: "小笼包",
        isUser: true,
        hanziItem: TextItem(previx: "我要买", suffix: "，多少钱？", highlight: "小笼包"),
        pinYinItem: TextItem(previx: "Wǒ yào mǎi ", suffix: ", duōshǎo qián?", highlight: "xiǎo lóng bāo")
    )
    
    static let talkAuntie12 = ConvTalk(
        hanzi: "十四块",
        pinyin: "Shísì kuài",
        translate: "Fourteen yuan.",
        highlight: "",
        hanziItem: TextItem(previx: "十四块", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Shísì kuài", suffix: "", highlight: "")
    )
    
    static let talkUser12 = ConvTalk(
        hanzi: "谢谢。 如果两份这个多少钱？我要买几份",
        pinyin: "xiè xie. Rúguǒ liǎng fèn duōshǎo qián? wǒ yào mǎi jǐ fèn",
        translate: "Thank you. If I buy two portions, how much would that be? I want to buy a few portions.",
        highlight: "谢谢",
        isUser: true,
        hanziItem: TextItem(previx: "", suffix: "。 如果两份这个多少钱？我要买几份", highlight: "谢谢"),
        pinYinItem: TextItem(previx: "", suffix: ". Rúguǒ liǎng fèn duōshǎo qián? wǒ yào mǎi jǐ fèn", highlight: "xiè xie")
    )
    
    static let talkAuntie13 = ConvTalk(
        hanzi: "十四块一份，两份二十七块",
        pinyin: "Shísì kuài yí fèn, liǎng fèn èrshíqī kuài",
        translate: "Fourteen yuan for one portion, twenty-seven yuan for two portions.",
        highlight: "",
        hanziItem: TextItem(previx: "十四块一份，两份二十七块", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Shísì kuài yí fèn, liǎng fèn èrshíqī kuài", suffix: "", highlight: "")
    )
    
    static let talkUser13 = ConvTalk(
        hanzi: "好的，我要一份，谢谢 阿姨",
        pinyin: "Hǎo de, wǒ yào yí fèn, xièxie āyí",
        translate: "Alright, I'll take one portion. Thank you, auntie.",
        highlight: "阿姨",
        isUser: true,
        hanziItem: TextItem(previx: "好的，我要一份，谢谢 ", suffix: "", highlight: "阿姨"),
        pinYinItem: TextItem(previx: "Hǎo de, wǒ yào yí fèn, xièxie ", suffix: "", highlight: "āyí")
    )
    
    static let talkAuntie14 = ConvTalk(
        hanzi: "这给你，没事！",
        pinyin: "Zhè gěi nǐ, méi shì!",
        translate: "Here you go. No problem!",
        highlight: "",
        hanziItem: TextItem(previx: "这给你，没事！", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Zhè gěi nǐ, méi shì!", suffix: "", highlight: "")
    )
    
    static let talkUser14 = ConvTalk(
        hanzi: "",
        pinyin: "",
        translate: "",
        highlight: "",
        isUser: true,
        hanziItem: TextItem(previx: "", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "", suffix: "", highlight: "")
    )
    
    // talkUser6 || talkAuntie6 -- talkAuntie10 || talkUser 10 convo2, topic2
    static let talkAuntie15 = ConvTalk(
        hanzi: "你好！想买什么？",
        pinyin: "Nǐ hǎo! Xiǎng mǎi shénme?",
        translate: "Hello! What would you like to buy?",
        highlight: "",
        hanziItem: TextItem(previx: "你好！想买什么？", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Nǐ hǎo! Xiǎng mǎi shénme?", suffix: "", highlight: "")
    )
    
    static let talkUser15 = ConvTalk(
        hanzi: "我要买面条，多少钱？",
        pinyin: "Wǒ yào mǎi miàn tiáo, duōshǎo qián?",
        translate: "I'd like to buy noodles, how much is it?",
        highlight: "面条",
        isUser: true,
        hanziItem: TextItem(previx: "我要买", suffix: "，多少钱？", highlight: "面条"),
        pinYinItem: TextItem(previx: "Wǒ yào mǎi ", suffix: ", duōshǎo qián?", highlight: "miàn tiáo")
    )
    
    static let talkAuntie16 = ConvTalk(
        hanzi: "十四块",
        pinyin: "Shísì kuài",
        translate: "Fourteen yuan.",
        highlight: "",
        hanziItem: TextItem(previx: "十四块", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Shísì kuài", suffix: "", highlight: "")
    )
    
    static let talkUser16 = ConvTalk(
        hanzi: "感谢. 如果两份这个多少钱？我要买几份",
        pinyin: "Gǎn xiè. Rúguǒ liǎng fèn duōshǎo qián? wǒ yào mǎi jǐ fèn",
        translate: "Thanks. If I buy two portions, how much would it be? I want to buy a few portions.",
        highlight: "感谢",
        isUser: true,
        hanziItem: TextItem(previx: "", suffix: ". 如果两份这个多少钱？我要买几份", highlight: "感谢"),
        pinYinItem: TextItem(previx: "", suffix: ". Rúguǒ liǎng fèn duōshǎo qián? wǒ yào mǎi jǐ fèn", highlight: "Gǎn xiè")
    )
    
    static let talkAuntie17 = ConvTalk(
        hanzi: "十四块一份，两份二十七块",
        pinyin: "Shísì kuài yí fèn, liǎng fèn èrshíqī kuài",
        translate: "Fourteen yuan for one portion, twenty-seven yuan for two portions.",
        highlight: "",
        hanziItem: TextItem(previx: "十四块一份，两份二十七块", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Shísì kuài yí fèn, liǎng fèn èrshíqī kuài", suffix: "", highlight: "")
    )
    
    static let talkUser17 = ConvTalk(
        hanzi: "好的，我要一份，谢谢 叔叔",
        pinyin: "Hǎo de, wǒ yào yí fèn, xièxie shūshu",
        translate: "Alright, I'll take one portion. Thank you, uncle.",
        highlight: "叔叔",
        isUser: true,
        hanziItem: TextItem(previx: "好的，我要一份，谢谢 ", suffix: "", highlight: "叔叔"),
        pinYinItem: TextItem(previx: "Hǎo de, wǒ yào yí fèn, xièxie ", suffix: "", highlight: "shūshu")
    )
    
    static let talkAuntie18 = ConvTalk(
        hanzi: "这给你，没事！",
        pinyin: "Zhè gěi nǐ, méi shì!",
        translate: "Here you go. No problem!",
        highlight: "",
        hanziItem: TextItem(previx: "这给你，没事！", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "Zhè gěi nǐ, méi shì!", suffix: "", highlight: "")
    )
    
    static let talkUser18 = ConvTalk(
        hanzi: "",
        pinyin: "",
        translate: "",
        highlight: "",
        isUser: true,
        hanziItem: TextItem(previx: "", suffix: "", highlight: ""),
        pinYinItem: TextItem(previx: "", suffix: "", highlight: "")
    )
}
