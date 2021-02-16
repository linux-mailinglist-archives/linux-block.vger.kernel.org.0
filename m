Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C87431CA76
	for <lists+linux-block@lfdr.de>; Tue, 16 Feb 2021 13:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBPMP7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 16 Feb 2021 07:15:59 -0500
Received: from verein.lst.de ([213.95.11.211]:41059 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230144AbhBPMP6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Feb 2021 07:15:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 87A3967373; Tue, 16 Feb 2021 13:15:15 +0100 (CET)
Date:   Tue, 16 Feb 2021 13:15:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tom Seewald <tseewald@gmail.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        axboe@kernel.dk
Subject: Re: [Regression] [Bisected] Errors when ejecting USB storage
 drives since v5.10
Message-ID: <20210216121514.GA3647@lst.de>
References: <CAARYdbiUBxFTY25VusuxgxqVzNRnoB61fFQeXcmsKyDP_d_ipQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAARYdbiUBxFTY25VusuxgxqVzNRnoB61fFQeXcmsKyDP_d_ipQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I can't reproduce this with an AHCI attached CDROM.
