Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2B20AED8
	for <lists+linux-block@lfdr.de>; Fri, 26 Jun 2020 11:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgFZJQz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 26 Jun 2020 05:16:55 -0400
Received: from verein.lst.de ([213.95.11.211]:51059 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgFZJQz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 05:16:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0DF6E68CF0; Fri, 26 Jun 2020 11:16:53 +0200 (CEST)
Date:   Fri, 26 Jun 2020 11:16:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Message-ID: <20200626091652.GD26616@lst.de>
References: <20200625122152.17359-1-javier@javigon.com> <20200625122152.17359-7-javier@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625122152.17359-7-javier@javigon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As a bunch of folks noticed I don't zone_idx does what you think it
does.  That being said I'm very happy about any kind of validation
(except maybe in a supper hot path).  So if we want to validate the
zone number we can do, just not as in this patch.
