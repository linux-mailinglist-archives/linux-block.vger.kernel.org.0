Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865AD2F38EC
	for <lists+linux-block@lfdr.de>; Tue, 12 Jan 2021 19:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbhALSdq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Jan 2021 13:33:46 -0500
Received: from verein.lst.de ([213.95.11.211]:56840 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbhALSdq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 13:33:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B153D67373; Tue, 12 Jan 2021 19:33:03 +0100 (CET)
Date:   Tue, 12 Jan 2021 19:33:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Subject: Re: nvme: enable char device per namespace
Message-ID: <20210112183303.GA5050@lst.de>
References: <CGME20201216181838eucas1p15c687e5d1319d3fa581990e6cca73295@eucas1p1.samsung.com> <20201216181828.21040-1-javier.gonz@samsung.com> <20210111185347.oqqzdmoglg3lzo5y@mpHalley.localdomain> <20210112092207.GA4888@localhost.localdomain> <20210112183055.u3y34tfxh4d5aeue@unifi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210112183055.u3y34tfxh4d5aeue@unifi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 12, 2021 at 07:30:55PM +0100, Javier González wrote:
> I have not implemented multipath support, but it should definitely not
> crash like this. I'll rebase to 5.11 and test.
>
> Christoph: Is it OK to send this without multipath or should I just send
> all together?

We're not in a rush at the moment, so I'd prefer working multipath
support if you can spare a few cycles.
