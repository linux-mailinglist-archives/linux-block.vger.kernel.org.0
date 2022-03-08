Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3F84D1194
	for <lists+linux-block@lfdr.de>; Tue,  8 Mar 2022 09:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiCHIHo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Mar 2022 03:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbiCHIHn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 03:07:43 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B40F3EAAE
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 00:06:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7C88668AFE; Tue,  8 Mar 2022 09:06:43 +0100 (CET)
Date:   Tue, 8 Mar 2022 09:06:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 6/6] blk-mq: manage hctx map via xarray
Message-ID: <20220308080643.GA25696@lst.de>
References: <20220308073219.91173-1-ming.lei@redhat.com> <20220308073219.91173-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308073219.91173-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
