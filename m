Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAE62327B5
	for <lists+linux-block@lfdr.de>; Thu, 30 Jul 2020 00:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgG2Wsz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Jul 2020 18:48:55 -0400
Received: from sonic302-21.consmr.mail.ir2.yahoo.com ([87.248.110.84]:40972
        "EHLO sonic302-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbgG2Wsz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 18:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596062934; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=CdWeheczgfYd5hIj/YcFvbASx9SO7CNHpb9jHYkYJ9WBidaMuxTHB9mOwcxY9637yYMoGjYSU2kGmFcMMOhwRd7IaCNZk4mR2ioiTGv35zTbTEwRK9ednOaS9etfh1YCbMgsAfWwSLYdQsaQI9xd0WqrRNgWTUDdbmZPsmsGnvfQztVUJEc4DveUaAHFLPUlGVxAMUIRKliZ3GguCAa2ZAMDZHwxdh6YtHl1RQs7Jx3aqfLDx893v+6LZCmLw9FCmg0c8Bet4H6/V1aahL40JBoBPqoyRCA+uiY0ph37pNan7R9h3NL8GHqKh6yuEbpZSJIVIP+17bDGfVYusXN5hg==
X-YMail-OSG: mEEHePMVM1mXmjtHvLMf7AR4dDXisG8Ws2a1NcmsXP.MvM5dSXnUMQlK.UYQ34t
 NO2w5aUUrLdnhYCThQXa1Xgk8iajcg.WhN9x2f1qgEc5kIdHhGEo4xyo9UV0tf7o92o9aIW6l7Nu
 RiCrdYoRWZFyMW2Mp_zteFdfQ9TxhO1ap5bZabGY6qAKCTvGXuArouUUJsKJUeacuicwtbmCQRsp
 E028VaWqAc7MAjoUXMcRLeG.zVLtpgOfPXwL6KFrdgtx1Wu2P.SkvnlvE1oVMRr6HM89YRYafdQ2
 BJhR3yrhPzXdFvHGUUm9J0Q2EL5g0XHK50HOj_PqQpl7Ok9_N_pV0ub0W3Lw4dClBL64fX_sDpWS
 6rRIhUr7zR7X8Wp63wxETcSgKON13nS0KKagiKS6qOvOh0YzxsYG4vx2uwx6Rrnbmr6iXWsV71ZT
 qgUuFwl6aZTkj5z9E3Lxwo9DRt_XsBAohvPfl9M8y8GJp0U2QPoJ3AiCUF5nyNsMSsDodZj1RNet
 aYoxVCmrMggNniFHSIAkmKuuXifbWAuwLp3l0QwUW2TtqQskQmKU9Q_AUVpduC0xMDonp73Q6MrV
 DkWCIeR1ZY6ucfVuTCdTFSjdCE5rzc3Ou2YUdMtUrgjnRxHv_ENEcslIkGUXqG04n1SNQkKrkZg3
 NVyQ_oQwUqFKpnI.8mxO3y09AiBYEK215wM1tbhHqFGnwoDElYbmcUD9.beNAJ6ZONk0kBmlO9Gd
 eV5SaJidpTbQACFtl_MS1iGwxRLFiFRp4ewwP8jEOy22yYy2U6ubO0ia9pkdePdQQqoC.TRo2RUW
 U2NUmBw1ft41PJiDipKyZ6ac04pBmwHl.0Y5z_0GGzjjQFo0GLHwQDTJxVHPmkyhp5D9EoX5VI7L
 p4A46LxrLssCITq8xD5R1_jD7ZLh1Em_ImNc7NZATlKe246ntzntozj7BI0O.tgJCiL78EvBLu6W
 mfYC1kSN_niaRCRI40Do3vCMaPbSG4Od1MHXKGaoTh9X7A3cWEZwk2P72uE5Cwx1LomcMVJ1eVVt
 uHoX4A0jJFMbyeEZBn0Mg7464VXnRMsSZVca_62l4cD9_StRqVVs5GJOAoKmN4fqbTfl4ONo9gQQ
 zgeDo59L_0Id34ciGtikqoaaLRQnsXVj98CQ3_7TRAdGVkTBYMblfE5.lSxFJtLe0eIRRPfI6RS0
 B.y.apFw2rZA8yuQxxkagBkQlX.bHPbMx3_LDArOQK4OA_0_RhPr6TvqSEZFlKGyjP8iLmwUTAQF
 bpHuN3x_orhWLqm0gFMSspvxk5s1zm1GFy638zy4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Wed, 29 Jul 2020 22:48:54 +0000
Date:   Wed, 29 Jul 2020 22:48:51 +0000 (UTC)
From:   " Mrs. Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: mrsminaabrunel57044@gmail.com
Message-ID: <117950056.13673805.1596062931331@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <117950056.13673805.1596062931331.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politicians who owns a small=
 gold company in Burkina Faso; He died of Leprosy and Radesyge, in year Feb=
ruary 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Milli=
on Euro) Eight million, Five hundred thousand Euros in a bank in Ouagadougo=
u the capital city of of Burkina in West Africa. The money was from the sal=
e of his company and death benefits payment and entitlements of my deceased=
 husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
