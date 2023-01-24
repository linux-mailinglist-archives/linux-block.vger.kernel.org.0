Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86CD679B2E
	for <lists+linux-block@lfdr.de>; Tue, 24 Jan 2023 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbjAXOLB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Jan 2023 09:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjAXOLB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 09:11:01 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8961042BDB;
        Tue, 24 Jan 2023 06:11:00 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3427068D09; Tue, 24 Jan 2023 14:45:18 +0100 (CET)
Date:   Tue, 24 Jan 2023 14:45:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, hca@linux.ibm.com,
        gor@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-block@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH] s390/dcssblk:: don't call bio_split_to_limits
Message-ID: <20230124134517.GA26408@lst.de>
References: <20230123075356.60847-1-hch@lst.de> <Y8/gDgQfQA7++8tw@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8/gDgQfQA7++8tw@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 24, 2023 at 02:41:34PM +0100, Alexander Gordeev wrote:
> If my understanding is correct that this change was as good as
> early as commit 54efd50bfd87 ("block: make generic_make_request
> handle arbitrarily sized bios") took place and simply fell into
> the second category?

Yes.
