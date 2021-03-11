Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F3A337885
	for <lists+linux-block@lfdr.de>; Thu, 11 Mar 2021 16:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbhCKPyf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 11 Mar 2021 10:54:35 -0500
Received: from verein.lst.de ([213.95.11.211]:41584 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234101AbhCKPya (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 10:54:30 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 80D7168B05; Thu, 11 Mar 2021 16:54:27 +0100 (CET)
Date:   Thu, 11 Mar 2021 16:54:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v2] block: Suppress uevent for hidden device when
 removed
Message-ID: <20210311155427.GA23641@lst.de>
References: <20210311151917.136091-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311151917.136091-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
