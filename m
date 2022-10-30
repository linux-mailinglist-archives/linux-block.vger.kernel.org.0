Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6706128D7
	for <lists+linux-block@lfdr.de>; Sun, 30 Oct 2022 08:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJ3Hg6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 30 Oct 2022 03:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJ3Hg5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 03:36:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FAD296;
        Sun, 30 Oct 2022 00:36:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 69D5168AA6; Sun, 30 Oct 2022 08:36:52 +0100 (CET)
Date:   Sun, 30 Oct 2022 08:36:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     axboe@kernel.dk, bvanassche@acm.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: simplify blksize_bits() implementation
Message-ID: <20221030073651.GA4131@lst.de>
References: <TYCP286MB23238842958D7C083D6B67CECA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB23238842958D7C083D6B67CECA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm not sure if it matters, but the change does look fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
