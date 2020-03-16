Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 329BB1869D4
	for <lists+linux-block@lfdr.de>; Mon, 16 Mar 2020 12:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgCPLRI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Mar 2020 07:17:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:38064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730560AbgCPLRI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 07:17:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CEABBAD79;
        Mon, 16 Mar 2020 11:17:05 +0000 (UTC)
Message-ID: <34bb7fc55efb7231ba51c6e3ff539701d2dbd28a.camel@suse.com>
Subject: Re: disk revalidation updates and OOM
From:   Martin Wilck <mwilck@suse.com>
To:     He Zhe <zhe.he@windriver.com>, Christoph Hellwig <hch@lst.de>,
        jack@suse.cz, Jens Axboe <axboe@kernel.dk>,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, keith.busch@intel.com,
        tglx@linutronix.de, yuyufen@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Mar 2020 12:17:12 +0100
In-Reply-To: <3315bffe-80d2-ca43-9d24-05a827483fce@windriver.com>
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
         <209f06496c1ef56b52b0ec67c503838e402c8911.camel@suse.com>
         <47735babf2f02ce85e9201df403bf3e1ec5579d6.camel@suse.com>
         <3315bffe-80d2-ca43-9d24-05a827483fce@windriver.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Zhe,

On Mon, 2020-03-16 at 19:02 +0800, He Zhe wrote:
> 
> > Is it possible that you have the legacy udisksd running, and didn't
> > disable CD-ROM polling?
> 
> Thanks for the suggestion, I'll try this ASAP.

Since this is difficult to reproduce and you said this happens in a VM,
would you mind uploading the image and qemu settings somewhere, so that
others could have a look?

Regards,
Martin


