Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDCC67725
	for <lists+linux-block@lfdr.de>; Sat, 13 Jul 2019 02:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfGMAB5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 12 Jul 2019 20:01:57 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60716 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbfGMAB5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 20:01:57 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hm5U8-0004XU-4w; Fri, 12 Jul 2019 18:01:52 -0600
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>
References: <20190712235742.22646-1-logang@deltatee.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d1bcf1fa-baed-dbf6-d04b-31df3f7ad30e@deltatee.com>
Date:   Fri, 12 Jul 2019 18:01:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712235742.22646-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, jthumshirn@suse.de, tytso@mit.edu, mmoese@suse.de, chaitanya.kulkarni@wdc.com, osandov@fb.com, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH blktests 00/12] Fix nvme block test issues
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Oh, I forgot to mention there is a git branch of these patches available
here:

https://github.com/Eideticom/blktests nvme_fixes

Logan

