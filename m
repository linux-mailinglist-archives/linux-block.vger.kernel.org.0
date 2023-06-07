Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BD272542A
	for <lists+linux-block@lfdr.de>; Wed,  7 Jun 2023 08:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjFGGa2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 7 Jun 2023 02:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbjFGGaP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 02:30:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6664F172B
        for <linux-block@vger.kernel.org>; Tue,  6 Jun 2023 23:30:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6310E68AA6; Wed,  7 Jun 2023 08:30:03 +0200 (CEST)
Date:   Wed, 7 Jun 2023 08:30:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ladislav Michl <oss-lists@triops.cz>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: ratelimit warning in bio_check_ro
Message-ID: <20230607063002.GA21239@lst.de>
References: <ZIAjht591AEza3c4@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIAjht591AEza3c4@lenoch>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 07, 2023 at 08:28:22AM +0200, Ladislav Michl wrote:
> From: Ladislav Michl <ladis@linux-mips.org>
> 
> Until 57e95e4670d1 ("block: fix and cleanup bio_check_ro")
> a WARN_ONCE was used to print a warning. Current pr_warn causes
> log flood, so use pr_warn_ratelimited instead.
> Once there adjust message to match the one used in bio_check_eod.

Do you have a case that hits this?  Beause we'd really need to fix it.

Otherwise this looks ok to me.
