Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2B5EB385B
	for <lists+linux-block@lfdr.de>; Mon, 16 Sep 2019 12:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfIPKkm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Sep 2019 06:40:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60733 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfIPKkm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 06:40:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED7AA10DCC91;
        Mon, 16 Sep 2019 10:40:41 +0000 (UTC)
Received: from [10.72.12.58] (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25B2319C78;
        Mon, 16 Sep 2019 10:40:39 +0000 (UTC)
Subject: Re: [PATCHv2 0/2] blk-mq: Avoid memory reclaim when allocating
 request map
To:     Christoph Hellwig <hch@infradead.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com,
        linux-block@vger.kernel.org
References: <20190916021631.4327-1-xiubli@redhat.com>
 <20190916090606.GA13266@infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <28bd4a18-eadb-b37c-6024-de7d6e76c80b@redhat.com>
Date:   Mon, 16 Sep 2019 18:40:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190916090606.GA13266@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Mon, 16 Sep 2019 10:40:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/9/16 17:06, Christoph Hellwig wrote:
> On Mon, Sep 16, 2019 at 07:46:29AM +0530, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> To make the patch more readable and cleaner I just split them into 2
>> small ones to address the issue from @Ming Lei, thanks very much.
> I'd be much happier to just see memalloc_noio_save +
> memalloc_noio_restore calls in the right places over sprinkling even
> more magic GFP_NOIO arguments.

Hi Christoph,

BTW, then to make the code to be more readable, should I just keep the 
BLK_MQ_GFP_GLAGS as:

#define BLK_MQ_GFP_FLAGS (GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY)

Or just switch to:

#define BLK_MQ_GFP_FLAGS (GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY)

?

Any advice about this ?

Thanks very much,
BRs
Xiubo
