Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2183329AB
	for <lists+linux-block@lfdr.de>; Tue,  9 Mar 2021 16:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhCIPGA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Mar 2021 10:06:00 -0500
Received: from verein.lst.de ([213.95.11.211]:60578 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhCIPFd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Mar 2021 10:05:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C9B168B05; Tue,  9 Mar 2021 16:05:31 +0100 (CET)
Date:   Tue, 9 Mar 2021 16:05:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
        minwoo.im.dev@gmail.com
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210309150531.GA15052@lst.de>
References: <20210301192452.16770-1-javier.gonz@samsung.com> <20210301192452.16770-2-javier.gonz@samsung.com> <20210303091022.GA12784@lst.de> <20210303100212.e43jgjvuomgybmy2@mpHalley.localdomain> <20210309113103.GA9233@lst.de> <20210309124104.uowad6bd4vlcthmw@mpHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309124104.uowad6bd4vlcthmw@mpHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 09, 2021 at 01:42:23PM +0100, Javier Gonz�lez wrote:
>> - nvme_cdev_fops implements file operations that directly on a nvme_ns,
>>   so they are path specific
>
> This is correct.
>
>> - we allow opening them even for a hidden controller
>
> This is also correct.
>
>> - there does not seem to be a char device node for ns_head at all.
>
> Also correct.
>
> We tried to keep it simple in the first iteration. Am I understanding
> that you see necessary to have per ns_head char devices?

That would be my understanding of "multipath support" for this character
device, yes.  Especially as hiding the individual char devices for the
hidden controllers once they are initially exposed would be an ABI break.
