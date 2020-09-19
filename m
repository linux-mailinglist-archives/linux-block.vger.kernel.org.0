Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B31270E20
	for <lists+linux-block@lfdr.de>; Sat, 19 Sep 2020 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgISN3K (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 19 Sep 2020 09:29:10 -0400
Received: from sonic302-2.consmr.mail.bf2.yahoo.com ([74.6.135.41]:41568 "EHLO
        sonic302-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbgISN3K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Sep 2020 09:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600522149; bh=QGYjayu/LHmWn6Oqzo8IfdgC/lTGP9gCPY5aQ14ZMf0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Lh6bFhJQ0mTrwpfzYo2NXfcrobTI4agqPkeajXNtae6yGhu/eufVDR2DnO7x0pkJ+ouraL2OnMr9o+NgwgLM1wdHsfdxSOMVgJEBzA8EbNq5+5N+MYuv+2ig0cqDoXBZJ8rG/g/PdlIixcXfWDRSv5XnxiUy3+FyjDq7gdFvlh3XG92cGNcOtgeiJPn1D2AMmMkWyUjh1PzP6YCmr3Pya0BJF3fmQNXZwnO1BJka36w1PtCdu9ViUVYH+4jZjw8Lz0Q1I8uvn/gjhLFrWQ6Mj5HjDw1QOlQsMMO4JFMjTc5j435mzwhaPd1cJmjAAkNgF9hgPIkleGY+FTW05ehuog==
X-YMail-OSG: gPqIrvcVM1n6sDEa2yEeIqqud0OBF8g9Zk6ebeeLfRHZOmJZ01Zi4Th9B91EdWn
 PDM7fKEAN9uLm19vR3VTy4oMwCA1jh16qfyGPUuDmAtKW1dCjvkF5xrRMHfiFvhvCLJmcX7wE2cd
 LATqub0M25UFTZCwM4OPPQ2fE8yqRRgg5X.8bOWystfvm7BYK0kb4eZnGBM4nlGyUwY56ToPvigj
 OOc9c0AgrgZKhilRHWRAhWMqSvLAdzJToWtp6wFjtZG0hUmnAb5rlVqptAGc8vAdSwvPtZqVzQWN
 pCkW0GwaKeVeJbcl.8GxnpEm5jn3FHUW9GBCVovKg8hiK.dEIM1rBz5Ql9W5ApXNsUrOpwcYUC2J
 IwgCghVNymDjMNHPSiH0l9UheQHxKVSAfV60c.k9hSfQDrZJCl_1Ju8J39_bOrQqM57AbcVWWUaK
 b4cbQcJS_.re.004UTTw9bWa6XOcHcHyRdbKJmWLGcSAug8aebjRma9C88oBjE2rgYj0xhO3cfrx
 pVO3aVpV6q8o.j3v0LSD5YVf_C8BW_RZ8pOJQMP6hZuyoMvXtXacAZxKIiCfwUcCYdx8nALbjT3a
 Rt_RjdNLeoOlgIFt6LyGrXpHcTIP9flwK8WiJMQb1GHkQXrk7Tq0Vkpq.myj87HarLIQygoKNuNE
 xwzT6c6pNEDbhiC1e9pfC9.kgg_6audmk1bULkIxCSpV073p7HOWOBoHWLfcqkkYhichsO6.6xeM
 k39FlEPzoS6qMWLdOcxFf_DhKAI4dcGhiR30tJhKrOEm6lyX46WQC33vMldKU1CFw_rDmQ.msITT
 OjCVkgqT1WHF_YZcttKm_tii3MOJXXs9dy4unO.7zCdb7129AxOwPdGwfCqKtKJriMAVtnUszCc9
 _FGqFzkuuxj00PL0VkS7I260mziA8T0XuQJEZF8WifsFViSQWARyjbMDY5W1tnaGihv.4jky0sHN
 5e2NtPRapckQH8HOPuiNDS3nV3ed.GARWxiG2ToSKq3_PekQ8tZIA.q1X2kNAro68nMB.PYJLk9c
 VaVN0Iw624X3UqRmO8e.Eel8vPxKFgWJ2Djiclwfgq0uTxaY4vBjV6KxOnWU3mzZR1k.1audRpyc
 LZlu2QjZQco8vYobxgYAiRraJCVShiX9ai1cTkceV5qGoX0wOfa81jOSxxbRJsA.qQQh4cez2t2K
 pBfUIbAmiFiQ2qvQuIydyngxqnC5owZ7tsilymKqUCV2uxxMRnGzRlzIxD0JEgdF.ApYXhzaPM2l
 YZDuUvVPJ9dMsiD.OVstGcQBl6v3ZoqoCUiW770INJs7sNYfDWxHeCidARtdNs6VzaKXVJ_cN2cO
 neGrULaV5LMpL.OjrxZRMGn03hVJEra55weSzDDp5FRGy2NCSc2G4CzwVwHqhFrNim1IuevP0.Sr
 HxMlrYGAkp2IchmIMWEYChvcKOScUmnRd9Wq.kazyi6KqZIEGb4URgnSPzQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Sat, 19 Sep 2020 13:29:09 +0000
Date:   Sat, 19 Sep 2020 13:29:06 +0000 (UTC)
From:   Romane Matheo <romanematheo1@gmail.com>
Reply-To: romanematheo0@gmail.com
Message-ID: <2049817183.3866750.1600522146069@mail.yahoo.com>
Subject: Hello Dear.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <2049817183.3866750.1600522146069.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Dear.

Please forgive me for stressing you with my predicaments as I know that thi=
s letter may come to you as big surprise.  Actually, I came across your E-m=
ail from my personal search afterward I decided to email you directly belie=
ving that you will be honest to fulfill my final wish before i die. Meanwhi=
le, I am Mrs.Romane Matheo, 62 years old, from France, and I am  suffering =
from a long time cancer and from all indication my condition is really dete=
riorating as my doctors have confirmed and courageously Advised me that I m=
ay not live beyond two months from now for the reason that my tumor has rea=
ched a  critical stage which has defiled all forms of medical treatment, As=
 a matter of fact, registered nurse by profession while my  husband was dea=
ling on Gold Dust and Gold Dory Bars till his sudden death the year 2018 th=
en I took over his business till date. In fact, at this moment I have a dep=
osit sum of Seven million five hundred thousand US dollars[$7,500,000.00] w=
ith one of the leading bank but unfortunately I cannot visit the bank since=
 I=E2=80=99m critically sick and powerless to do anything myself but my ban=
k account officer advised me to assign any of my trustworthy relative, frie=
nds or partner with authorization letter to stand as the recipient of my mo=
ney but sorrowfully I don=E2=80=99t have any reliable relative and no child=
.

Therefore, I want you to receive the money and take 50% to take care of you=
rself and family while 50% should be use basically on humanitarian purposes=
 mostly to orphanages home, Motherless babies home, less privileged and dis=
able citizens and widows around the world. And as soon as I receive your re=
spond I shall send you the full details with my pictures, banking records a=
nd with full contacts of my banking institution to communicate them on the =
matter.

Hope to hear from you soon.

Yours Faithfully,
Mrs. Romane Matheo
