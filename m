Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90DB3CAF7B
	for <lists+linux-block@lfdr.de>; Fri, 16 Jul 2021 01:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhGOXD1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-block@lfdr.de>); Thu, 15 Jul 2021 19:03:27 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:28793 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGOXDZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 19:03:25 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5E49B240003;
        Thu, 15 Jul 2021 23:00:29 +0000 (UTC)
Date:   Fri, 16 Jul 2021 01:00:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+118992efda475c16dfb0@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in loop_add
Message-ID: <20210716010028.4218b0de@xps13>
In-Reply-To: <c3d4ebd5-5679-cd81-d1de-4f5f2cbe13db@gmail.com>
References: <000000000000ec01e405c6c2cee3@google.com>
        <20210710131638.605-1-hdanton@sina.com>
        <20210712052740.GA8599@lst.de>
        <c3d4ebd5-5679-cd81-d1de-4f5f2cbe13db@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com> wrote on Mon, 12 Jul
2021 16:29:16 +0800:

> On 12/7/21 1:27 pm, Christoph Hellwig wrote:
> > On Sat, Jul 10, 2021 at 09:16:38PM +0800, Hillf Danton wrote:  
> >> To break the lock chain, un/register blkdev without mtd_table_mutex held.  
> > 
> > Yes, Desmond Cheong Zhi Xi sent pretty much the same patch on June 18th
> > (mtd: break circular locks in register_mtd_blktrans), but it did not get
> > picked up.
> >   
> 
> I believe Miquèl was waiting for -rc1 to apply it.

Indeed, I already applied it but did not advertise yet.

> 
> But taking a closer look, although the fix for the register path is the same, Hillf Danton's proposed patch additionally avoids inverting the lock hierarchy on the unregister path. So I believe this new patch should be more robust.

We can definitely do this in two steps if you want.

Thanks,
Miquèl
