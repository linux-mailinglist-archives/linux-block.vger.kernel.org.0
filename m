Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4E63512A
	for <lists+linux-block@lfdr.de>; Wed, 23 Nov 2022 08:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiKWHhr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Nov 2022 02:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbiKWHhp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 02:37:45 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B58E64DC;
        Tue, 22 Nov 2022 23:37:42 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2EDA568AFE; Wed, 23 Nov 2022 08:37:40 +0100 (CET)
Date:   Wed, 23 Nov 2022 08:37:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] elevator: update the document of elevator_match
Message-ID: <20221123073739.GC8328@lst.de>
References: <cover.1669126766.git.nickyc975@zju.edu.cn> <a58424555202c07a9ccf7f60c3ad7e247da09e25.1669126766.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a58424555202c07a9ccf7f60c3ad7e247da09e25.1669126766.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
