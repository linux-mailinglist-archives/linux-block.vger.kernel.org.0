Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9571BB709
	for <lists+linux-block@lfdr.de>; Tue, 28 Apr 2020 08:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgD1Gwk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Apr 2020 02:52:40 -0400
Received: from verein.lst.de ([213.95.11.211]:54358 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgD1Gwk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 02:52:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6ABC568CFC; Tue, 28 Apr 2020 08:52:36 +0200 (CEST)
Date:   Tue, 28 Apr 2020 08:52:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: bdi: fix use-after-free for dev_name(bdi->dev) v3
Message-ID: <20200428065236.GA18707@lst.de>
References: <20200422073851.303714-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422073851.303714-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

can you pick this series up?  At least 1-4 are probably usefu for 5.7
and -stable.
