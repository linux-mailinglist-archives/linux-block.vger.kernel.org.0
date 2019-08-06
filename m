Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3779D82C44
	for <lists+linux-block@lfdr.de>; Tue,  6 Aug 2019 09:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbfHFHF5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Aug 2019 03:05:57 -0400
Received: from verein.lst.de ([213.95.11.211]:53891 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731576AbfHFHF5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Aug 2019 03:05:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BFDE068B02; Tue,  6 Aug 2019 09:05:53 +0200 (CEST)
Date:   Tue, 6 Aug 2019 09:05:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hans Holmberg <hans@owltronix.com>
Cc:     Matias Bjorling <mb@lightnvm.io>, Christoph Hellwig <hch@lst.de>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] lightnvm: remove nvm_submit_io_sync_fn
Message-ID: <20190806070553.GA15546@lst.de>
References: <1564566096-28756-1-git-send-email-hans@owltronix.com> <1564566096-28756-2-git-send-email-hans@owltronix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564566096-28756-2-git-send-email-hans@owltronix.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 31, 2019 at 11:41:33AM +0200, Hans Holmberg wrote:
> Move the redundant sync handling interface and wait for a completion
> in the lightnvm core instead.
> 
> Signed-off-by: Hans Holmberg <hans@owltronix.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
