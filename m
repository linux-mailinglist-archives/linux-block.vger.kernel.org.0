Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 575B010E317
	for <lists+linux-block@lfdr.de>; Sun,  1 Dec 2019 19:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfLAS2O (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 1 Dec 2019 13:28:14 -0500
Received: from mtax.cdmx.gob.mx ([187.141.35.197]:12185 "EHLO mtax.cdmx.gob.mx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfLAS2O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Dec 2019 13:28:14 -0500
X-Greylist: delayed 7043 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Dec 2019 13:28:13 EST
X-NAI-Header: Modified by McAfee Email Gateway (4500)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cdmx.gob.mx; s=72359050-3965-11E6-920A-0192F7A2F08E;
        t=1575217645; h=DKIM-Filter:X-Virus-Scanned:
         Content-Type:MIME-Version:Content-Transfer-Encoding:
         Content-Description:Subject:To:From:Date:Message-Id:
         X-AnalysisOut:X-AnalysisOut:X-AnalysisOut:
         X-AnalysisOut:X-AnalysisOut:X-SAAS-TrackingID:
         X-NAI-Spam-Flag:X-NAI-Spam-Threshold:X-NAI-Spam-Score:
         X-NAI-Spam-Rules:X-NAI-Spam-Version; bh=M
        8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs4
        8=; b=c8ZPMmupfUT1nbRUtV9iOIRWvWMPxcO1fHVsknafpwq5
        Y28y5iqyVqZUpTza0uYfh2Cta8xnHwkoFCFNajRi5fN0k3e9SY
        +7UJxYBPJxdhemxyeM3m7J/5dAk5PuMZ8es8KDpaDAA/oNJn5E
        cgbo5t1T/UcK6AX5gHA33OV8gxc=
Received: from cdmx.gob.mx (correo.cdmx.gob.mx [10.250.108.150]) by mtax.cdmx.gob.mx with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 1dee_65a2_ad94ceba_abc9_4936_b2f5_5dd510bc1dd0;
        Sun, 01 Dec 2019 10:27:24 -0600
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 88A841E2B7B;
        Sun,  1 Dec 2019 10:18:51 -0600 (CST)
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P44nuqEl8CPI; Sun,  1 Dec 2019 10:18:51 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 1B0141E29B7;
        Sun,  1 Dec 2019 10:14:19 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx 1B0141E29B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=72359050-3965-11E6-920A-0192F7A2F08E; t=1575216859;
        bh=M8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs48=;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:To:
         From:Date:Message-Id;
        b=AeIVJz34Ne4zaKqVjoAAQ6R9Umh5eCWKxP3jlFpiCSEVAi8PuJR/z86rzxIBOv0Hc
         MkMAuAZUa003HueC8idxB3fv4iNMHORp7yBRnUMBpn0GuFImNWz8/x/01deLlKvQxm
         hGtVmQSzYqqyKmyuXoLFBASCROFBQm5I6gVmMF6I=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dzRrCmWTbUBb; Sun,  1 Dec 2019 10:14:19 -0600 (CST)
Received: from [192.168.0.104] (unknown [188.125.168.160])
        by cdmx.gob.mx (Postfix) with ESMTPSA id 2B1DD1E320C;
        Sun,  1 Dec 2019 10:05:27 -0600 (CST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Congratulations
To:     Recipients <aac-styfe@cdmx.gob.mx>
From:   "Bishop Johnr" <aac-styfe@cdmx.gob.mx>
Date:   Sun, 01 Dec 2019 17:05:20 +0100
Message-Id: <20191201160528.2B1DD1E320C@cdmx.gob.mx>
X-AnalysisOut: [v=2.2 cv=Rf/gMxlv c=1 sm=1 tr=0 p=6K-Ig8iNAUou4E5wYCEA:9 p]
X-AnalysisOut: [=zRI05YRXt28A:10 a=T6zFoIZ12MK39YzkfxrL7A==:117 a=9152RP8M]
X-AnalysisOut: [6GQqDhC/mI/QXQ==:17 a=8nJEP1OIZ-IA:10 a=pxVhFHJ0LMsA:10 a=]
X-AnalysisOut: [pGLkceISAAAA:8 a=wPNLvfGTeEIA:10 a=M8O0W8wq6qAA:10 a=Ygvjr]
X-AnalysisOut: [iKHvHXA2FhpO6d-:22]
X-SAAS-TrackingID: be9e3ed5.0.105105104.00-2388.176706380.s12p02m011.mxlogic.net
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 3
X-NAI-Spam-Score: -5000
X-NAI-Spam-Rules: 1 Rules triggered
        WHITELISTED=-5000
X-NAI-Spam-Version: 2.3.0.9418 : core <6686> : inlines <7165> : streams
 <1840193> : uri <2949750>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Money was donated to you by Mr and Mrs Allen and Violet Large, just contact=
 them with this email for more information =


EMail: allenandvioletlargeaward@gmail.com
