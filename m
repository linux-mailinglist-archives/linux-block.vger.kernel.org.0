Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CA54E5F57
	for <lists+linux-block@lfdr.de>; Thu, 24 Mar 2022 08:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348537AbiCXH2p (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Mar 2022 03:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiCXH2o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 03:28:44 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6986998F63;
        Thu, 24 Mar 2022 00:27:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V83t.bs_1648106829;
Received: from 30.225.28.175(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0V83t.bs_1648106829)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Mar 2022 15:27:10 +0800
Message-ID: <c26b28c1-b9d8-7570-b631-8cdda0f9de73@linux.alibaba.com>
Date:   Thu, 24 Mar 2022 15:27:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RFC 1/3] mm/memory.c: introduce vm_insert_page(s)_mkspecial
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        xuyu@linux.alibaba.com, bostroesser@gmail.com
References: <20220318095531.15479-1-xiaoguang.wang@linux.alibaba.com>
 <20220318095531.15479-2-xiaoguang.wang@linux.alibaba.com>
 <YjtOpf1bf0qH87HD@infradead.org>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
In-Reply-To: <YjtOpf1bf0qH87HD@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hi,

> I relaly don't think we should add this amount of overhead to the
> core VM for a (relatively) irrelevant driver.
OK, but as what I have described in cover letter, both vm_insert_pages and
remap_pfn_range have performance or usage limits. Do you know any better
method to map block device io request's sgl pages to user space? I think 
block
device backend implemented in use space will benefit from this feature, 
thanks.

Regards,
Xiaoguang Wang
