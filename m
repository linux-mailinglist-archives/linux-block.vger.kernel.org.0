Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413DA20B4AF
	for <lists+linux-block@lfdr.de>; Fri, 26 Jun 2020 17:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgFZPfR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 26 Jun 2020 11:35:17 -0400
Received: from fallback22.m.smailru.net ([94.100.176.132]:49254 "EHLO
        fallback22.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgFZPfQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 11:35:16 -0400
X-Greylist: delayed 3129 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jun 2020 11:35:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:Cc:To:From:Subject:Message-ID; bh=sRthVSPitv/Iiss9OKUPY0U2XZAyIrIr0VSJReMu+oI=;
        b=GfFp3somaD0HldLNiuo2Hj9ycCndyOmZYP1GjPvYbTgqgyOGjnXr4jXR1h4J4QSJuTt9OjLMH6LpEq+30lhw91iEazBNagPu4WZgAi4Dx5wYLSWduONrRQLEFYiwoa/s6WMRM4y+jIX95Yja4q+9o1NJcdmc4Vy84nd2ZaZLd1A=;
Received: from [10.161.8.33] (port=56470 helo=smtp14.mail.ru)
        by fallback22.m.smailru.net with esmtp (envelope-from <alekseymmm@mail.ru>)
        id 1jopZI-0000xH-UK
        for linux-block@vger.kernel.org; Fri, 26 Jun 2020 17:43:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:Cc:To:From:Subject:Message-ID; bh=sRthVSPitv/Iiss9OKUPY0U2XZAyIrIr0VSJReMu+oI=;
        b=GfFp3somaD0HldLNiuo2Hj9ycCndyOmZYP1GjPvYbTgqgyOGjnXr4jXR1h4J4QSJuTt9OjLMH6LpEq+30lhw91iEazBNagPu4WZgAi4Dx5wYLSWduONrRQLEFYiwoa/s6WMRM4y+jIX95Yja4q+9o1NJcdmc4Vy84nd2ZaZLd1A=;
Received: by smtp14.mail.ru with esmtpa (envelope-from <alekseymmm@mail.ru>)
        id 1jopZG-0000wd-Rp; Fri, 26 Jun 2020 17:43:03 +0300
Message-ID: <bdef634a3a41dbecfd3d74f6bd25332445772902.camel@mail.ru>
Subject: [PATCH] block: Set req quiet flag if bio is quiet
From:   Aleksei Marov <alekseymmm@mail.ru>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Date:   Fri, 26 Jun 2020 17:42:57 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9AAC5A87EC32CE31EB6E01BDE3D7D768BA8AF3A12D18E8808182A05F538085040D86B18E1040BBA3D17501CAD2EDD5236E5F8C3F1A4DEAC88DE6DAB2DD5FAFFAC
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75263010198C72082EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006374E88016F1B7D8D248638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC1BBC24754C4447ECE38699F1802EB0649E86EB6C6D3CCE24389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0B687D752F9FE62218941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C3CF36E64A7E3F8E58117882F4460429728AD0CFFFB425014E40A5AABA2AD371193AA81AA40904B5D9A18204E546F3947C188B2BFCDC338A02302FCEF25BFAB3454AD6D5ED66289B52F4A82D016A4342E36136E347CC761E07725E5C173C3A84C391C27F7DDB3D8653BA3038C0950A5D36B5C8C57E37DE458B0B4866841D68ED3567F23339F89546C55F5C1EE8F4F765FC851EDB9C5A93305EA7F4EDE966BC389F395957E7521B51C24C7702A67D5C33162DBA43225CD8A89FB26E97DCB74E62526D8C47C27EEC5E9FB5C8C57E37DE458B4C7702A67D5C3316FA3894348FB808DBCF17F1EDFBC1FB573B503F486389A921A5CC5B56E945C8DA
X-C8649E89: BCF06AA3CCCA8578954EA8024B853CFC88E089A39DD221185FB641856D73F50EBD11DAA2EA1E4AA2
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojtcCHZoKxZplKQq1SrXrNSg==
X-Mailru-Sender: 8261CADE3D3FA0B4BDFD1058942BD7EAC90364FBA45CA0A3BA3E703A3B4AEC6A4EE14B57AC70EBE9FEDCCAD94ABAB60078274A4A9E9E44FD4301F6103F424F867A458BE9B16E12C867EA787935ED9F1B
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: 669901E4625912A97F9F52485CB584D7271FD7DF62800FDCD5510F06DA415DA1CCC07CCE96A7512D9A7B7E3ADDB2F70AC33B6F82A77BB66C
X-7FA49CB5: 0D63561A33F958A56F4977E42B6025E87355F023759C49794A3C34F1D6E80E8E8941B15DA834481FA18204E546F3947C7BD21ED50D08CA4DF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B974A882099E279BDA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249EF499754DBF6557476E601842F6C81A12EF20D2F80756B5F7874E805F1D05189089D37D7C0E48F6CA18204E546F3947CB26E97DCB74E625235872C767BF85DA22EF20D2F80756B5F40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE79E9721B410A3B6ED731C566533BA786A40A5AABA2AD371193C9F3DD0FB1AF5EBF64ED337B09931FD27F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojtcCHZoKxZpkYVIgdco1iyw==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005D917D4885F602B38B1BB42EB0835CAB893B68AA7122B399BB7EA9FE7735C3DBF82C4A51CE75DF6B43DDE9B364B0DF2897376EA924B960F6E96C236757D6432D5AE208404248635DF
X-Mras: Ok
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The current behavior is that if bio flagged as BIO_QUIETis submitted to request based block device then the request
that wraps this bio in a queue is not quiet. RQF_FLAG is not
set anywhere. Hence, if errors happen we can see error
messages (e.g. in print_req_error) even though bio is quiet.
This patch fixes that by setting the flag in blk_rq_bio_prep.

Signed-off-by: Aleksei Marov <alekseymmm@mail.ru>
---
 block/blk.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index b5d1f0f..04ca4e0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -108,6 +108,9 @@ static inline void blk_rq_bio_prep(struct request
*rq, struct bio *bio,

        if (bio->bi_disk)
                rq->rq_disk = bio->bi_disk;
+
+       if (bio_flagged(bio, BIO_QUIET))
+               rq->rq_flags |= RQF_QUIET;
 }

 #ifdef CONFIG_BLK_DEV_INTEGRITY
-- 
1.8.3.1


