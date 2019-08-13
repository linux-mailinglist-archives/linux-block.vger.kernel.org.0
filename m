Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFA18BDE1
	for <lists+linux-block@lfdr.de>; Tue, 13 Aug 2019 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfHMP7v (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Aug 2019 11:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12561 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfHMP7v (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 11:59:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3937C8E589;
        Tue, 13 Aug 2019 15:59:51 +0000 (UTC)
Received: from [10.10.122.147] (ovpn-122-147.rdu2.redhat.com [10.10.122.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E03447FB8C;
        Tue, 13 Aug 2019 15:59:50 +0000 (UTC)
Subject: Re: [PATCH 4/4] nbd: fix zero cmd timeout handling
To:     Josef Bacik <josef@toxicpanda.com>
References: <20190809212610.19412-1-mchristi@redhat.com>
 <20190809212610.19412-5-mchristi@redhat.com>
 <20190813131357.dpyd5mqbfubqhiaa@MacBook-Pro-91.local>
 <5D52DB33.8070307@redhat.com> <5D52DD27.6090202@redhat.com>
Cc:     linux-block@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D52DE76.2010803@redhat.com>
Date:   Tue, 13 Aug 2019 10:59:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <5D52DD27.6090202@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 13 Aug 2019 15:59:51 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/13/2019 10:54 AM, Mike Christie wrote:
> I was debating about sending a patch for not allowing
> 
> blk_queue_rq_timeout(q, 9)

I meant zero

blk_queue_rq_timeout(q, 0)

> 
> in a separate patchset, but I was not sure if people use that for
> testing fast timeouts.
> 

